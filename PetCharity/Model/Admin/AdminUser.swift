//
//  AdminUser.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/7.
//

import Foundation

struct AdminUser: Codable {
    var id, sex: Int?
    var phone, nickname, introduction, qq, sexValue: String?
    var head, token, createTime: String?

    enum CodingKeys: String, CodingKey {
        case id
        case sexValue = "sex_value"
        case phone, nickname, qq, sex, introduction, head, token
        case createTime = "create_time"
    }
    
    init() {
        
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<AdminUser.CodingKeys> = try decoder.container(keyedBy: AdminUser.CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: AdminUser.CodingKeys.id)
        self.sexValue = try container.decodeIfPresent(String.self, forKey: AdminUser.CodingKeys.sexValue)
        self.phone = try container.decodeIfPresent(String.self, forKey: AdminUser.CodingKeys.phone)
        self.nickname = try container.decodeIfPresent(String.self, forKey: AdminUser.CodingKeys.nickname)
        self.qq = try container.decodeIfPresent(String.self, forKey: AdminUser.CodingKeys.qq)
        self.sex = try container.decodeIfPresent(Int.self, forKey: AdminUser.CodingKeys.sex)
        self.introduction = try container.decodeIfPresent(String.self, forKey: AdminUser.CodingKeys.introduction)
        self.head = try container.decodeIfPresent(String.self, forKey: AdminUser.CodingKeys.head)
        self.token = try container.decodeIfPresent(String.self, forKey: AdminUser.CodingKeys.token)
        self.createTime = try container.decodeIfPresent(String.self, forKey: AdminUser.CodingKeys.createTime)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<AdminUser.CodingKeys> = encoder.container(keyedBy: AdminUser.CodingKeys.self)
        
        try container.encodeIfPresent(self.id, forKey: AdminUser.CodingKeys.id)
        try container.encodeIfPresent(self.sexValue, forKey: AdminUser.CodingKeys.sexValue)
        try container.encodeIfPresent(self.phone, forKey: AdminUser.CodingKeys.phone)
        try container.encodeIfPresent(self.nickname, forKey: AdminUser.CodingKeys.nickname)
        try container.encodeIfPresent(self.qq, forKey: AdminUser.CodingKeys.qq)
        try container.encodeIfPresent(self.sex, forKey: AdminUser.CodingKeys.sex)
        try container.encodeIfPresent(self.introduction, forKey: AdminUser.CodingKeys.introduction)
        try container.encodeIfPresent(self.head, forKey: AdminUser.CodingKeys.head)
        try container.encodeIfPresent(self.token, forKey: AdminUser.CodingKeys.token)
        try container.encodeIfPresent(self.createTime, forKey: AdminUser.CodingKeys.createTime)
    }
}
extension AdminUser: RawRepresentable {

    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(Self.self, from: data) else { return nil }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8) else { return "" }
        return result
    }
}
