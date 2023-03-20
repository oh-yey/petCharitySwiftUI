//
//  Area.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/7.
//

import Foundation

struct Area: Codable {
    let id: Int
    let area: String
    let belongCity: City

    enum CodingKeys: String, CodingKey {
        case id, area
        case belongCity = "belong_city"
    }
    
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Area.CodingKeys> = try decoder.container(keyedBy: Area.CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: Area.CodingKeys.id)
        self.area = try container.decode(String.self, forKey: Area.CodingKeys.area)
        self.belongCity = try container.decode(City.self, forKey: Area.CodingKeys.belongCity)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Area.CodingKeys> = encoder.container(keyedBy: Area.CodingKeys.self)
        
        try container.encode(self.id, forKey: Area.CodingKeys.id)
        try container.encode(self.area, forKey: Area.CodingKeys.area)
        try container.encode(self.belongCity, forKey: Area.CodingKeys.belongCity)
    }
}
