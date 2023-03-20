//
//  AdminApi.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/7.
//

import Foundation

class AdminApi: NetworkApi {
    
    /// 登录
    static func login(_ phone: String, _ password: String, completion: @escaping (Result<DataDetail<AdminUser>, Error>) -> Void) {
        NetworkManager.shared.doPost(
            path: "/administrator/login",
            parameters: [
                "phone": phone,
                "password": password
            ]
        ) { result in
            switch result {
            case let .success(data):
                completion(parsData(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
