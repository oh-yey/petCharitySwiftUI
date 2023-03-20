//
//  View+.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/7.
//

import SwiftUI

extension View {
    // preference<K>(key: K.Type = K.self, value: K.Value) -> some View where K : PreferenceKey
    func readGeometry<K: PreferenceKey, Value>(key: K.Type,_ keyPath: KeyPath<GeometryProxy, Value>) -> some View where K.Value == Value {
        overlay {
            GeometryReader { proxy in
                Color.clear.preference(key: key, value: proxy[keyPath:keyPath])
            }
        }
    }
    
    func card() -> some View {
        background(Color("CardBg"))
        .cornerRadius(12)
    }
    
    func overlayBox() -> some View {
        padding()
            .overlay {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color(UIColor.systemGray4), lineWidth: 1)
            }
    }
}
