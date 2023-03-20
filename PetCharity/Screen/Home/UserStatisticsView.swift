//
//  UserStatisticsView.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/9.
//

import SwiftUI
import Charts

// MARK: - 用户比例
struct UserStatisticsView: View {
    @State private var shouldShow = false
    @State private var userStatistics = [UserStatistics]()
    
    var body: some View {
        Group {
            if shouldShow {
                VStack {
                    HStack {
                        Text("用户比例")
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    Spacer()
                    Chart(userStatistics) {
                        BarMark(x: .value("数量", $0.count))
                            .foregroundStyle(by:  .value("性别", $0.sexValue))
                    }
                    .frame(height: 48)
                    
                    Spacer()
                    
                }
            } else {
                ProgressView()
            }
        }
        .padding()
        .task {
            StatisticsApi.userStatistics { result in
                switch result {
                case let .success(data):
                    withAnimation {
                        userStatistics = data.data ?? []
                        shouldShow = true
                    }
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
}

struct UserStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(selected: .home)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
