//
//  MainView.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/7.
//

import SwiftUI


// MARK: - MainView
struct MainView: View {
    @AppStorage(.adminUser) private var adminUser: AdminUser = .init()
    @State var selected: MenuUnit = .home
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                leftView
                    .frame(width: geometry.size.width * 0.25, height: geometry.size.height)
                    .background(Color("CardBg"))
                
                rightView
                    .frame(width: geometry.size.width * 0.75, height: geometry.size.height)
                    .background(Color("AppBg2"))
                    .transition(.scale.combined(with: .opacity))
            }
            
        }
        .cornerRadius(12)
        .padding()
        .padding()
        .background(Color("AppBg"))
    }
}

enum MenuUnit: String, CaseIterable, Identifiable, View {
    
    case home = "后台首页"
    case donate = "众筹管理"
    case female = "用户反馈"
    
    var id: Self { self }
    
    var body: some View {
        HStack(spacing: 0) {
            Image(svg)
                .resizable()
                .frame(width: 24,height: 24)
            
            Spacer()
                .frame(width: 8)
            
            Text(rawValue)
                .font(.callout)
            
            Spacer()
            
            
        }
        .padding([.vertical, .leading])
    }
    
    var svg: String  {
        switch self {
        case .home:
            return "home"
        case .donate:
            return "donate"
        case .female:
            return  "female"
        }
    }
    
    
}
// MARK: - 左边部分
extension MainView {
    @ViewBuilder var titleView: some View {
        HStack(spacing: 0) {
            Image("pet")
                .resizable()
                .frame(width: 48,height: 48)
            
            Spacer()
                .frame(width: 4)
            
            Text("宠物爱心公益平台")
                .font(.callout)
                .fontWeight(.bold)
            
            Divider()
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 4)
            
            Text("管理后台")
                .font(.caption)
                .opacity(0.625)
            
        }
        .padding(.vertical)
    }
    
    
    @ViewBuilder private var leftView: some View {
        VStack(spacing: 0) {
            titleView
            
            ForEach(MenuUnit.allCases) { item in
                item
                    .fontWeight(selected == item ?  .bold : .thin)
                    .opacity(selected == item ? 1 : 0.5)
                    .foregroundColor(selected == item ? Color.accentColor : nil)
                    .overlay {
                        if selected == item {
                            HStack {
                                Spacer()
                                
                                Color.accentColor
                                    .frame(width: 4,height: 32)
                                    .cornerRadius(4)
                                    .id("selectedDivider")
                                    .transition(.identity)
                            }
                            
                        }
                    }
                    .background(Color("CardBg"))
                    .onTapGesture {
                        withAnimation {
                            selected = item
                        }
                    }
                
            }
            Spacer()
        }
    }
}

// MARK: - 右边部分
extension MainView {
    @ViewBuilder private var rightView: some View {
        switch selected {
        case .home:
            HomeView()
        case .donate:
            DonateView()
        case .female:
            FemaleView()
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainView()
        }
        .previewInterfaceOrientation(.landscapeLeft)
    }
}
