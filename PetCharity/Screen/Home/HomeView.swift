//
//  HomeView.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/9.
//

import SwiftUI

// MARK: - 后台首页
struct HomeView: View {
    var body: some View {
        VStack {
            
            HoneTopView()
            
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        // 左上
                        DonateAmountStatisticsView()
                            .frame(width: geometry.size.width * 0.65, height: geometry.size.height * 0.55)
                            .card()
                        
                        Spacer()
                        
                        // 左下
                        DonateAmountTopView()
                            .frame(width: geometry.size.width * 0.65, height: geometry.size.height * 0.45)
                            .card()
                        
                        
                    }
                    .frame(width: geometry.size.width * 0.65, height: geometry.size.height)
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        // 右上
                        UserStatisticsView()
                            .frame(width: geometry.size.width * 0.35, height: geometry.size.height * 0.3)
                            .card()
                        
                        Spacer()
                        
                        // 右下
                        AdminInfoView()
                        .frame(width: geometry.size.width * 0.35, height: geometry.size.height * 0.7)
                        .card()
                        
                    }
                    .frame(width: geometry.size.width * 0.35, height: geometry.size.height)
                    
                }
            }
            .padding(.all, 24)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(selected: .home)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
