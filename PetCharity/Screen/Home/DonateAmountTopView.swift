//
//  DonateAmountTopView.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/9.
//

import SwiftUI

// MARK: - 众筹最近10天Top10
struct DonateAmountTopView: View {
    
    @State private var shouldShow = false
    @State private var petDonateTopList = [PetDonateList]()
    @State private var sortOrder = [KeyPathComparator(\PetDonateList.donate)]
    
    var body: some View {
        
        Group {
            if shouldShow {
                VStack {
                    Text("众筹最近10天Top10")
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    Table(petDonateTopList, sortOrder: $sortOrder) {
                        TableColumn("用户", value: \.user.phone)
                            .width(min: 60, max: 200)
                        TableColumn("金额", value: \.amount) {
                            Text("\($0.amount)")
                        }
                        .width(min: 60, max: 200)
                        TableColumn("捐赠时间", value: \.donateTime) {
                            Text(django2String($0.donateTime))
                        }
                        .width(min: 200, max: 300)
                    }
                    .scrollContentBackground(.hidden)
                    .onChange(of: sortOrder) { newOrder in
                        petDonateTopList.sort(using: newOrder)
                    }
                }
            } else {
                ProgressView()
            }
        }
        .task {
            StatisticsApi.donateAmountTop { result in
                switch result {
                case let .success(data):
                    withAnimation {
                        petDonateTopList = data.data ?? []
                        shouldShow = true
                    }
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
}

struct DonateAmountTopView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(selected: .home)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
