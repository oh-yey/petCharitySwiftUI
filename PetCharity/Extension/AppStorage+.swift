//
//  AppStorage+.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/7.
//

import SwiftUI


extension AppStorage {
    init(wrappedValue:Value ,_ key: UserDefaults.Key, store: UserDefaults? = nil) where Value == Bool {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }

    init(wrappedValue: Value, _ key: UserDefaults.Key, store: UserDefaults? = nil) where Value: RawRepresentable, Value.RawValue == String {
          self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
      }
}


