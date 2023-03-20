//
//  UserDefaults+.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/9.
//

import Foundation

extension UserDefaults {
    func string(forKey defaultName: UserDefaults.Key) -> String? {
        self.string(forKey: defaultName.rawValue)
    }

    
    func set(_ value: Bool, forKey defaultName: UserDefaults.Key) {
        self.set(value, forKey: defaultName.rawValue)
    }
    func set(_ value: Any?, forKey defaultName: UserDefaults.Key) {
        self.set(value, forKey: defaultName.rawValue)
    }
    func removeObject(forKey defaultName: UserDefaults.Key) {
        self.removeObject(forKey: defaultName.rawValue)
    }

}
