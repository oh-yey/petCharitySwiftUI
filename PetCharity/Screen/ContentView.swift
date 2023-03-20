//
//  ContentView.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/7.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var systemData = SystemDataModel()
    
    @AppStorage(.isLogin) private var isLoing = false
    
    @AppStorage(.adminUser) private var adminUser: AdminUser = .init()
    
    
    var body: some View {
        NavigationStack {
            if isLoing {
                MainView()
                    .transition(.scale)
            } else {
                LoginView()
                    .transition(.scale)
                    .environmentObject(systemData)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
