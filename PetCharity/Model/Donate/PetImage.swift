//
//  Image.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/11.
//

import Foundation

struct PetImage: Codable, Identifiable {
    let id: Int
    let image: String
    let width, height: Int?
    
    enum CodingKeys: CodingKey {
        case id
        case image
        case width
        case height
    }
    
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<PetImage.CodingKeys> = try decoder.container(keyedBy: PetImage.CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: PetImage.CodingKeys.id)
        self.image = try container.decode(String.self, forKey: PetImage.CodingKeys.image)
        self.width = try container.decodeIfPresent(Int.self, forKey: PetImage.CodingKeys.width)
        self.height = try container.decodeIfPresent(Int.self, forKey: PetImage.CodingKeys.height)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<PetImage.CodingKeys> = encoder.container(keyedBy: PetImage.CodingKeys.self)
        
        try container.encode(self.id, forKey: PetImage.CodingKeys.id)
        try container.encode(self.image, forKey: PetImage.CodingKeys.image)
        try container.encodeIfPresent(self.width, forKey: PetImage.CodingKeys.width)
        try container.encodeIfPresent(self.height, forKey: PetImage.CodingKeys.height)
    }
}
