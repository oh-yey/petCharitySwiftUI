//
//  Detail.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/20.
//

import Foundation

struct Detail: Codable {
    let code: Int
    let detail: String?
    
    enum CodingKeys: CodingKey {
        case code
        case detail
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Detail.CodingKeys> = try decoder.container(keyedBy: Detail.CodingKeys.self)
        
        self.code = try container.decode(Int.self, forKey: Detail.CodingKeys.code)
        self.detail = try container.decodeIfPresent(String.self, forKey: Detail.CodingKeys.detail)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Detail.CodingKeys> = encoder.container(keyedBy: Detail.CodingKeys.self)
        
        try container.encode(self.code, forKey: Detail.CodingKeys.code)
        try container.encodeIfPresent(self.detail, forKey: Detail.CodingKeys.detail)
    }
}

