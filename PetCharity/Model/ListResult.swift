//
//  ListResult.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/11.
//

import Foundation

struct ListResult<T: Codable>: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [T]
    
    enum CodingKeys: CodingKey {
        case count
        case next
        case previous
        case results
    }
    
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<ListResult<T>.CodingKeys> = try decoder.container(keyedBy: ListResult<T>.CodingKeys.self)
        
        self.count = try container.decode(Int.self, forKey: ListResult<T>.CodingKeys.count)
        self.next = try container.decodeIfPresent(String.self, forKey: ListResult<T>.CodingKeys.next)
        self.previous = try container.decodeIfPresent(String.self, forKey: ListResult<T>.CodingKeys.previous)
        self.results = try container.decode([T].self, forKey: ListResult<T>.CodingKeys.results)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<ListResult<T>.CodingKeys> = encoder.container(keyedBy: ListResult<T>.CodingKeys.self)
        
        try container.encode(self.count, forKey: ListResult<T>.CodingKeys.count)
        try container.encodeIfPresent(self.next, forKey: ListResult<T>.CodingKeys.next)
        try container.encodeIfPresent(self.previous, forKey: ListResult<T>.CodingKeys.previous)
        try container.encode(self.results, forKey: ListResult<T>.CodingKeys.results)
    }
}
