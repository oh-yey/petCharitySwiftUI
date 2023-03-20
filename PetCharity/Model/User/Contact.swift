//
//  Contact.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/9.
//

import Foundation

struct Contact: Codable {
    let phone, mail, qq, wechat: String?
    
    enum CodingKeys: CodingKey {
        case phone
        case mail
        case qq
        case wechat
    }
    
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Contact.CodingKeys> = try decoder.container(keyedBy: Contact.CodingKeys.self)
        
        self.phone = try container.decodeIfPresent(String.self, forKey: Contact.CodingKeys.phone)
        self.mail = try container.decodeIfPresent(String.self, forKey: Contact.CodingKeys.mail)
        self.qq = try container.decodeIfPresent(String.self, forKey: Contact.CodingKeys.qq)
        self.wechat = try container.decodeIfPresent(String.self, forKey: Contact.CodingKeys.wechat)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Contact.CodingKeys> = encoder.container(keyedBy: Contact.CodingKeys.self)
        
        try container.encodeIfPresent(self.phone, forKey: Contact.CodingKeys.phone)
        try container.encodeIfPresent(self.mail, forKey: Contact.CodingKeys.mail)
        try container.encodeIfPresent(self.qq, forKey: Contact.CodingKeys.qq)
        try container.encodeIfPresent(self.wechat, forKey: Contact.CodingKeys.wechat)
    }
   
}
