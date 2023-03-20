//
//  NetworkApi.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/7.
//

import Foundation


class NetworkApi {
    
    static func parsData<T: Decodable>(_ data: Data) -> Result<T, Error> {
        guard let data = try? JSONDecoder().decode(T.self, from: data) else {
            let error = NSError(domain: "JSON解析错误", code: -1, userInfo: [NSLocalizedDescriptionKey: "JSON"])
            print(error)
            return .failure(error)
        }
        return .success(data)
    }
    
}
