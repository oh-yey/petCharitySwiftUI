//
//  Breed.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/11.
//

import Foundation

struct PetBreed: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let race: Int
    let path: String
    let variety: String
    
    var raceValue:  String {
        race == 0 ? "猫" :
        race == 1 ? "狗" : "其他"
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case race
        case path
        case variety
    }
    
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<PetBreed.CodingKeys> = try decoder.container(keyedBy: PetBreed.CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: PetBreed.CodingKeys.id)
        self.name = try container.decode(String.self, forKey: PetBreed.CodingKeys.name)
        self.race = try container.decode(Int.self, forKey: PetBreed.CodingKeys.race)
        self.path = try container.decode(String.self, forKey: PetBreed.CodingKeys.path)
        self.variety = try container.decode(String.self, forKey: PetBreed.CodingKeys.variety)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<PetBreed.CodingKeys> = encoder.container(keyedBy: PetBreed.CodingKeys.self)
        
        try container.encode(self.id, forKey: PetBreed.CodingKeys.id)
        try container.encode(self.name, forKey: PetBreed.CodingKeys.name)
        try container.encode(self.race, forKey: PetBreed.CodingKeys.race)
        try container.encode(self.path, forKey: PetBreed.CodingKeys.path)
        try container.encode(self.variety, forKey: PetBreed.CodingKeys.variety)
    }
    
    
}
