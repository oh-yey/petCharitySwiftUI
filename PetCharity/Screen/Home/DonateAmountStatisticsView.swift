//
//  DonateAmountStatisticsView.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/9.
//

import SwiftUI
import Charts

// MARK: - 众筹金额最近10天统计
struct DonateAmountStatisticsView: View {
    
    @State private var shouldShow = false
    @State private var chartData = [DonateAmountStatistics]()
    
    var body: some View {
        Group {
            if shouldShow {
                VStack {
                    Text("众筹金额最近10天统计")
                        .fontWeight(.bold)
                    Chart(chartData) {
                        BarMark(
                            x: .value("月份", $0.date),
                            y: .value("金额", $0.amount)
                        )
                    }
                    .padding()
                }
            } else {
                ProgressView()
            }
        }
        .padding()
        .task {
            StatisticsApi.donateAmountStatistics { result in
                switch result {
                case let .success(data):
                    withAnimation {
                        chartData = data.data ?? []
                        shouldShow = true
                    }
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}


struct DonateAmountStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(selected: .home)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
