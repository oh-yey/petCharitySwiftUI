//
//  Statistics.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/9.
//

import Foundation

struct DonateAmountStatistics: Codable, Identifiable {
    let id = UUID()
    let date: String
    let amount: Int
    
    enum CodingKeys: CodingKey {
        case date
        case amount
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<DonateAmountStatistics.CodingKeys> = try decoder.container(keyedBy: DonateAmountStatistics.CodingKeys.self)
        
        self.date = try container.decode(String.self, forKey: DonateAmountStatistics.CodingKeys.date)
        self.amount = try container.decode(Int.self, forKey: DonateAmountStatistics.CodingKeys.amount)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DonateAmountStatistics.CodingKeys.self)
        
        try container.encode(self.date, forKey: DonateAmountStatistics.CodingKeys.date)
        try container.encode(self.amount, forKey: DonateAmountStatistics.CodingKeys.amount)
    }
    
    
}
