//
//  SFSymbol.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/7.
//

import SwiftUI
/// - Tag: SFSymbol
enum SFSymbol: String {

    
    case phone = "phone.circle"
    case nickname = "n.circle"
    case introduction = "i.circle"
    case sex = "person.circle"
    case qq = "q.circle"
    case createTime = "timer"
    case search = "magnifyingglass"
    case start = "star"
    case startFill = "star.fill"
    case look = "doc.text.magnifyingglass"
    case del = "trash"
    case close = "multiply.circle"
}
extension SFSymbol: View {
    var body: Image {
        Image(systemName: rawValue)
    }
    
    func resizable() -> Image {
        body.resizable()
    }
}

extension Label where Title == Text, Icon == Image {
    /// [systemImage](x-source-tag://SFSymbol)
    init(_ title: String, systemImage: SFSymbol) {
        self.init(title, systemImage: systemImage.rawValue)
    }
}
