//
//  DataDetail.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/7.
//

import Foundation

struct DataDetail<T: Codable>: Codable {
    let code: Int
    let detail: String?
    let data: T?
    
    enum CodingKeys: CodingKey {
        case code
        case detail
        case data
    }
    
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<DataDetail<T>.CodingKeys> = try decoder.container(keyedBy: DataDetail<T>.CodingKeys.self)
        
        self.code = try container.decode(Int.self, forKey: DataDetail<T>.CodingKeys.code)
        self.detail = try container.decodeIfPresent(String.self, forKey: DataDetail<T>.CodingKeys.detail)
        self.data = try container.decodeIfPresent(T.self, forKey: DataDetail<T>.CodingKeys.data)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<DataDetail<T>.CodingKeys> = encoder.container(keyedBy: DataDetail<T>.CodingKeys.self)
        
        try container.encode(self.code, forKey: DataDetail<T>.CodingKeys.code)
        try container.encodeIfPresent(self.detail, forKey: DataDetail<T>.CodingKeys.detail)
        try container.encodeIfPresent(self.data, forKey: DataDetail<T>.CodingKeys.data)
    }
}
