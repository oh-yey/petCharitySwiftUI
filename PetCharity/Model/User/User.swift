//
//  User.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/9.
//

import Foundation

struct User: Codable {
    
    
    
    let id: Int
    let phone, introduction, identityValue: String
    let sex, identity: Int
    let area: Area
    let verified: Bool
    let followersCount, followingCount: Int
    let contact: Contact
    let nickname, qq, sexValue, head, createTime: String?

    enum CodingKeys: String, CodingKey {
        case id
        case sexValue = "sex_value"
        case identityValue = "identity_value"
        case verified
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case contact, nickname, phone, qq, sex, identity, introduction, head
        case createTime = "create_time"
        case area
    }
    
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<User.CodingKeys> = try decoder.container(keyedBy: User.CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: User.CodingKeys.id)
        self.sexValue = try container.decodeIfPresent(String.self, forKey: User.CodingKeys.sexValue)
        self.identityValue = try container.decode(String.self, forKey: User.CodingKeys.identityValue)
        self.verified = try container.decode(Bool.self, forKey: User.CodingKeys.verified)
        self.followersCount = try container.decode(Int.self, forKey: User.CodingKeys.followersCount)
        self.followingCount = try container.decode(Int.self, forKey: User.CodingKeys.followingCount)
        self.contact = try container.decode(Contact.self, forKey: User.CodingKeys.contact)
        self.nickname = try container.decodeIfPresent(String.self, forKey: User.CodingKeys.nickname)
        self.phone = try container.decode(String.self, forKey: User.CodingKeys.phone)
        self.qq = try container.decodeIfPresent(String.self, forKey: User.CodingKeys.qq)
        self.sex = try container.decode(Int.self, forKey: User.CodingKeys.sex)
        self.identity = try container.decode(Int.self, forKey: User.CodingKeys.identity)
        self.introduction = try container.decode(String.self, forKey: User.CodingKeys.introduction)
        self.head = try container.decodeIfPresent(String.self, forKey: User.CodingKeys.head)
        self.createTime = try container.decodeIfPresent(String.self, forKey: User.CodingKeys.createTime)
        self.area = try container.decode(Area.self, forKey: User.CodingKeys.area)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<User.CodingKeys> = encoder.container(keyedBy: User.CodingKeys.self)
        
        try container.encode(self.id, forKey: User.CodingKeys.id)
        try container.encodeIfPresent(self.sexValue, forKey: User.CodingKeys.sexValue)
        try container.encode(self.identityValue, forKey: User.CodingKeys.identityValue)
        try container.encode(self.verified, forKey: User.CodingKeys.verified)
        try container.encode(self.followersCount, forKey: User.CodingKeys.followersCount)
        try container.encode(self.followingCount, forKey: User.CodingKeys.followingCount)
        try container.encode(self.contact, forKey: User.CodingKeys.contact)
        try container.encodeIfPresent(self.nickname, forKey: User.CodingKeys.nickname)
        try container.encode(self.phone, forKey: User.CodingKeys.phone)
        try container.encodeIfPresent(self.qq, forKey: User.CodingKeys.qq)
        try container.encode(self.sex, forKey: User.CodingKeys.sex)
        try container.encode(self.identity, forKey: User.CodingKeys.identity)
        try container.encode(self.introduction, forKey: User.CodingKeys.introduction)
        try container.encodeIfPresent(self.head, forKey: User.CodingKeys.head)
        try container.encodeIfPresent(self.createTime, forKey: User.CodingKeys.createTime)
        try container.encode(self.area, forKey: User.CodingKeys.area)
    }
}
