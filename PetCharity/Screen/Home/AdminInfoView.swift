//
//  AdminInfoView.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/10.
//

import SwiftUI

// MARK: - 管理员信息
struct AdminInfoView: View {
    @AppStorage(.adminUser) private var adminUser: AdminUser = .init()
    @State private var showingAlert = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("管理员信息")
                    .fontWeight(.bold)
                
                
                Spacer()
                
                Button("注销") {
                    showingAlert = true
                }
                .foregroundColor(Color.red)
                .alert(isPresented:$showingAlert) {
                    Alert(
                        title: Text("您确定要注销吗?"),
                        message: Text("此操作无法撤销"),
                        primaryButton: .destructive(Text("注销")) {
                            UserDefaults.standard.removeObject(forKey: .adminUser)
                            UserDefaults.standard.removeObject(forKey: .token)
                            UserDefaults.standard.removeObject(forKey: .isLogin)
                        },
                        secondaryButton: .cancel()
                    )
                }
                
                
            }
            
            MyLabel(adminUser.nickname ?? "", .nickname)
            MyLabel(adminUser.phone ?? "", .phone)
            MyLabel(adminUser.introduction ?? "", .introduction)
            MyLabel(adminUser.sexValue ?? "", .sex)
            MyLabel(adminUser.qq ?? "", .qq)
            MyLabel(django2String(adminUser.createTime ?? ""), .createTime)
            
            Spacer()
            
        }
        .padding()
    }
    
    private func MyLabel(_ title: String,_  systemImage: SFSymbol) -> some View {
        Label(title, systemImage: systemImage)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .padding(.all, 8)
    }
}

struct AdminInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(selected: .home)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
