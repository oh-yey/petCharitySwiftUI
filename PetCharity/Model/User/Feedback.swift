//
//  Feedback.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/11.
//

import Foundation

struct Feedback: Codable, Identifiable {
    let id: Int
    let nickname, title, content: String
    let score: Int
    let createTime: String

    enum CodingKeys: String, CodingKey {
        case id, nickname, title, content, score
        case createTime = "create_time"
    }
    
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Feedback.CodingKeys> = try decoder.container(keyedBy: Feedback.CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: Feedback.CodingKeys.id)
        self.nickname = try container.decode(String.self, forKey: Feedback.CodingKeys.nickname)
        self.title = try container.decode(String.self, forKey: Feedback.CodingKeys.title)
        self.content = try container.decode(String.self, forKey: Feedback.CodingKeys.content)
        self.score = try container.decode(Int.self, forKey: Feedback.CodingKeys.score)
        self.createTime = try container.decode(String.self, forKey: Feedback.CodingKeys.createTime)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Feedback.CodingKeys> = encoder.container(keyedBy: Feedback.CodingKeys.self)
        
        try container.encode(self.id, forKey: Feedback.CodingKeys.id)
        try container.encode(self.nickname, forKey: Feedback.CodingKeys.nickname)
        try container.encode(self.title, forKey: Feedback.CodingKeys.title)
        try container.encode(self.content, forKey: Feedback.CodingKeys.content)
        try container.encode(self.score, forKey: Feedback.CodingKeys.score)
        try container.encode(self.createTime, forKey: Feedback.CodingKeys.createTime)
    }
    
    
   
}
