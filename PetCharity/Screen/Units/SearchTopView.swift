//
//  SearchTopView.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/10.
//

import SwiftUI

struct SearchTopView: View {
    @AppStorage(.adminUser) var adminUser: AdminUser = .init()
    
    @State private var searchText: String = ""
    
    private let onSubmit: ((String) -> Void)
    
    public init( onSubmit: @escaping ((String) -> Void)) {
        self.onSubmit = onSubmit
    }
    
    
    var body: some View {
        HStack {
            HStack {
                SFSymbol.search
                TextField("搜索", text: $searchText)
                    .keyboardType(.webSearch)
                    .onSubmit({
                        onSubmit(searchText)
                    })
            }
            .padding()
            .padding(.horizontal)
            .background(Color("CardBg"))
            .cornerRadius(8)
            .padding(.trailing)
            .frame(maxWidth: 300)
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

struct FemaleTopView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(selected: .female)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
