//
//  String+.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/10.
//

import Foundation

extension String {
   func validate(_ reg: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", reg)
        return predicate.evaluate(with: self)
    }
}
