//
//  Province.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/7.
//

import Foundation

struct Province: Codable {
    let id: Int
    let province: String
    
    enum CodingKeys: CodingKey {
        case id
        case province
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Province.CodingKeys> = try decoder.container(keyedBy: Province.CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: Province.CodingKeys.id)
        self.province = try container.decode(String.self, forKey: Province.CodingKeys.province)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Province.CodingKeys.self)
        
        try container.encode(self.id, forKey: Province.CodingKeys.id)
        try container.encode(self.province, forKey: Province.CodingKeys.province)
    }
}
