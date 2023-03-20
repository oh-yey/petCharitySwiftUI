//
//  PetDonate.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/11.
//

import Foundation

struct PetDonate: Codable, Identifiable {
    let id: Int
    var sex: Int
    var images: [PetImage]
    var coverImage: PetImage
    var donationList: [PetDonateList]?
    var alreadyAmount, alreadyPeopleCount: Int?
    var name, birth, description: String
    var weight: Double
    var amount, state: Int
    var createTime, publishTime, finishTime: String?
    var breed: PetBreed
    
    var stateValue: String {
        state == 0 ? "待发布":
        state == 1 ? "众筹中": "众筹结束"
    }
    var sexValue: String {
        sex == 0 ? "公": "母"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case images
        case coverImage = "cover_image"
        case donationList = "donation_list"
        case alreadyAmount = "already_amount"
        case alreadyPeopleCount = "already_people_count"
        case sex, name, weight, birth, description, amount, state
        case createTime = "create_time"
        case publishTime = "publish_time"
        case finishTime = "finish_time"
        case breed
    }
    
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<PetDonate.CodingKeys> = try decoder.container(keyedBy: PetDonate.CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: PetDonate.CodingKeys.id)
        self.images = try container.decode([PetImage].self, forKey: PetDonate.CodingKeys.images)
        self.coverImage = try container.decode(PetImage.self, forKey: PetDonate.CodingKeys.coverImage)
        self.donationList = try container.decodeIfPresent([PetDonateList].self, forKey: PetDonate.CodingKeys.donationList)
        self.alreadyAmount = try container.decodeIfPresent(Int.self, forKey: PetDonate.CodingKeys.alreadyAmount)
        self.alreadyPeopleCount = try container.decodeIfPresent(Int.self, forKey: PetDonate.CodingKeys.alreadyPeopleCount)
        self.sex = try container.decode(Int.self, forKey: PetDonate.CodingKeys.sex)
        self.name = try container.decode(String.self, forKey: PetDonate.CodingKeys.name)
        self.weight = try Double(container.decode(String.self, forKey: PetDonate.CodingKeys.weight)) ?? 0
        self.birth = try container.decode(String.self, forKey: PetDonate.CodingKeys.birth)
        self.description = try container.decode(String.self, forKey: PetDonate.CodingKeys.description)
        self.amount = try container.decode(Int.self, forKey: PetDonate.CodingKeys.amount)
        self.state = try container.decode(Int.self, forKey: PetDonate.CodingKeys.state)
        self.createTime = try container.decodeIfPresent(String.self, forKey: PetDonate.CodingKeys.createTime)
        self.publishTime = try container.decodeIfPresent(String.self, forKey: PetDonate.CodingKeys.publishTime)
        self.finishTime = try container.decodeIfPresent(String.self, forKey: PetDonate.CodingKeys.finishTime)
        self.breed = try container.decode(PetBreed.self, forKey: PetDonate.CodingKeys.breed)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<PetDonate.CodingKeys> = encoder.container(keyedBy: PetDonate.CodingKeys.self)
        
        try container.encode(self.id, forKey: PetDonate.CodingKeys.id)
        try container.encode(self.images, forKey: PetDonate.CodingKeys.images)
        try container.encode(self.coverImage, forKey: PetDonate.CodingKeys.coverImage)
        try container.encodeIfPresent(self.donationList, forKey: PetDonate.CodingKeys.donationList)
        try container.encodeIfPresent(self.alreadyAmount, forKey: PetDonate.CodingKeys.alreadyAmount)
        try container.encodeIfPresent(self.alreadyPeopleCount, forKey: PetDonate.CodingKeys.alreadyPeopleCount)
        try container.encode(self.sex, forKey: PetDonate.CodingKeys.sex)
        try container.encode(self.name, forKey: PetDonate.CodingKeys.name)
        try container.encode(self.weight, forKey: PetDonate.CodingKeys.weight)
        try container.encode(self.birth, forKey: PetDonate.CodingKeys.birth)
        try container.encode(self.description, forKey: PetDonate.CodingKeys.description)
        try container.encode(self.amount, forKey: PetDonate.CodingKeys.amount)
        try container.encode(self.state, forKey: PetDonate.CodingKeys.state)
        try container.encodeIfPresent(self.createTime, forKey: PetDonate.CodingKeys.createTime)
        try container.encodeIfPresent(self.publishTime, forKey: PetDonate.CodingKeys.publishTime)
        try container.encodeIfPresent(self.finishTime, forKey: PetDonate.CodingKeys.finishTime)
        try container.encode(self.breed, forKey: PetDonate.CodingKeys.breed)
    }
}
