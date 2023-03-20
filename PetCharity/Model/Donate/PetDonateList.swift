//
//  PetDonateList.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/9.
//

import Foundation

import Foundation

struct PetDonateList: Codable, Identifiable {
    let id: Int
    let user: User
    let amount: Int
    let order, remarks, donateTime: String
    let donate: Int

    enum CodingKeys: String, CodingKey {
        case id, user, amount, order, remarks
        case donateTime = "donate_time"
        case donate
    }
    
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<PetDonateList.CodingKeys> = try decoder.container(keyedBy: PetDonateList.CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: PetDonateList.CodingKeys.id)
        self.user = try container.decode(User.self, forKey: PetDonateList.CodingKeys.user)
        self.amount = try container.decode(Int.self, forKey: PetDonateList.CodingKeys.amount)
        self.order = try container.decode(String.self, forKey: PetDonateList.CodingKeys.order)
        self.remarks = try container.decode(String.self, forKey: PetDonateList.CodingKeys.remarks)
        self.donateTime = try container.decode(String.self, forKey: PetDonateList.CodingKeys.donateTime)
        self.donate = try container.decode(Int.self, forKey: PetDonateList.CodingKeys.donate)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<PetDonateList.CodingKeys> = encoder.container(keyedBy: PetDonateList.CodingKeys.self)
        
        try container.encode(self.id, forKey: PetDonateList.CodingKeys.id)
        try container.encode(self.user, forKey: PetDonateList.CodingKeys.user)
        try container.encode(self.amount, forKey: PetDonateList.CodingKeys.amount)
        try container.encode(self.order, forKey: PetDonateList.CodingKeys.order)
        try container.encode(self.remarks, forKey: PetDonateList.CodingKeys.remarks)
        try container.encode(self.donateTime, forKey: PetDonateList.CodingKeys.donateTime)
        try container.encode(self.donate, forKey: PetDonateList.CodingKeys.donate)
    }
}


