//
//  UserStatistics.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/9.
//

import Foundation

struct UserStatistics: Codable, Identifiable {
    let id = UUID()
    let sex: String
    let sexValue: String
    let count: Int
    
    enum CodingKeys: CodingKey {
        case sex
        case sexValue
        case count
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<UserStatistics.CodingKeys> = try decoder.container(keyedBy: UserStatistics.CodingKeys.self)
        
        self.sex = try container.decode(String.self, forKey: UserStatistics.CodingKeys.sex)
        self.sexValue = try container.decode(String.self, forKey: UserStatistics.CodingKeys.sexValue)
        self.count = try container.decode(Int.self, forKey: UserStatistics.CodingKeys.count)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserStatistics.CodingKeys.self)
        
        try container.encode(self.sex, forKey: UserStatistics.CodingKeys.sex)
        try container.encode(self.sexValue, forKey: UserStatistics.CodingKeys.sexValue)
        try container.encode(self.count, forKey: UserStatistics.CodingKeys.count)
    }
}
