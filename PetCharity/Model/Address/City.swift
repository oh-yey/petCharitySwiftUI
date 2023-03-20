//
//  City.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/7.
//

import Foundation
struct City: Codable {
    let id: Int
    let city: String
    let belongProvince: Province
    
    enum CodingKeys: String, CodingKey {
        case id, city
        case belongProvince = "belong_province"
    }
    
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<City.CodingKeys> = try decoder.container(keyedBy: City.CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: City.CodingKeys.id)
        self.city = try container.decode(String.self, forKey: City.CodingKeys.city)
        self.belongProvince = try container.decode(Province.self, forKey: City.CodingKeys.belongProvince)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<City.CodingKeys> = encoder.container(keyedBy: City.CodingKeys.self)
        
        try container.encode(self.id, forKey: City.CodingKeys.id)
        try container.encode(self.city, forKey: City.CodingKeys.city)
        try container.encode(self.belongProvince, forKey: City.CodingKeys.belongProvince)
    }
    
    
}
