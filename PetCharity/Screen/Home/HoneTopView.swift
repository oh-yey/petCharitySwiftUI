//
//  HoneTopView.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/10.
//

import SwiftUI

// MARK: - 后台首页Top
struct HoneTopView: View {
    @AppStorage(.adminUser) private var adminUser: AdminUser = .init()
    
    var amOrPm: String {
        data2String(Date(), dateFormat: "aaa")
    }
    
    // 注册天数
    var registrationDay: Int {
        let createTime = string2Date(adminUser.createTime ?? "") ?? Date();
        return Int(Date().timeIntervalSince(createTime) / (60 * 60 * 24))
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("\(amOrPm)好， \(adminUser.nickname ?? "管理员")")
                    .font(.title)
                
                HStack(spacing: 0) {
                    Text("今天是宠物爱心公益平台后台管理系統陪您的")
                    Text("\(registrationDay)")
                        .foregroundColor(Color.accentColor)
                    Text("天，请继续加油哦")
                    
                }
                .font(.title3)
                .opacity(0.5)
                
            }
            Spacer()
            
            AsyncImage(url: URL(string: adminUser.head ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 48, height: 48)
            .cornerRadius(24)
            .padding(.vertical)
            
            Text(adminUser.nickname ?? "管理员")
                .font(.title3)
                .opacity(0.375)
        }
        .padding()
        .padding(.horizontal)
    }
}

struct HoneTopView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(selected: .home)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
