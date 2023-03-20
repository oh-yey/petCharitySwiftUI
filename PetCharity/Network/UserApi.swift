//
//  UserApi.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/11.
//

import Foundation

class UserApi: NetworkApi {
    
    static func feedbackList(_ searchText: String, page: Int = 1, completion: @escaping (Result<ListResult<Feedback>, Error>) -> Void) {
        NetworkManager.shared.doGet(
            path: "/user/feedback/list", 
            parameters: ["search": searchText, "page": page]
        ) { result in
            switch result {
            case let .success(data):
                completion(parsData(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func delFeedbackById(_ id: Int, completion: @escaping(Bool) -> Void) {
        NetworkManager.shared.doDelete(path: "/user/feedback/\(id)", completion: completion)
    }
}
