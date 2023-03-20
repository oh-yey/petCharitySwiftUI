//
//  StatisticsApi.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/9.
//

import Foundation
// 数据统计
class StatisticsApi: NetworkApi {
    
    static func donateAmountStatistics(completion: @escaping (Result<DataDetail<[DonateAmountStatistics]>, Error>) -> Void) {
        NetworkManager.shared.doGet(path: "/statistics/admin/donateAmountStatistics") { result in
            switch result {
            case let .success(data):
                completion(parsData(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    static func donateAmountTop(completion: @escaping (Result<DataDetail<[PetDonateList]>, Error>) -> Void) {
        NetworkManager.shared.doGet(path: "/statistics/admin/donateAmountTop") { result in
            switch result {
            case let .success(data):
                completion(parsData(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func userStatistics(completion: @escaping (Result<DataDetail<[UserStatistics]>, Error>) -> Void) {
        NetworkManager.shared.doGet(path: "/statistics/admin/userStatistics") { result in
            switch result {
            case let .success(data):
                completion(parsData(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
