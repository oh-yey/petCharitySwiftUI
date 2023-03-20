//
//  LinearGradient+.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/7.
//

import SwiftUI

extension ShapeStyle where Self == LinearGradient {
    
    public static func myLinearGradient1() -> LinearGradient {
        .linearGradient(
            colors: .init([
                Color.init(red: 127 / 255.0, green: 127 / 255.0, blue: 213 / 255.0),
                Color.init(red: 134 / 255.0, green: 168 / 255.0, blue: 231 / 255.0),
                Color.init(red: 145 / 255.0, green: 234 / 255.0, blue: 228 / 255.0)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
