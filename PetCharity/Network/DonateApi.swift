//
//  DonateApi.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/12.
//

import Foundation


class DonateApi: NetworkApi {
    
    static func donateList(_ searchText: String, page: Int = 1, completion: @escaping (Result<ListResult<PetDonate>, Error>) -> Void) {
        NetworkManager.shared.doGet(
            path: "/donate/list",
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
    
    static func delDonate(_ id: Int, completion: @escaping(Bool) -> Void) {
        NetworkManager.shared.doDelete(path: "/donate/delete/\(id)", completion: completion)
    }
    
    static func donateCreate(
        name: String,
        breed: Int,
        sex: Int,
        weight: Double,
        birth: String,
        description: String,
        amount: Int,
        images: [Int],
        coverImage: Int,
        completion: @escaping (Result<PetDonate, Error>) -> Void
    ) {
        NetworkManager.shared.doPost(
            path: "/donate/create",
            parameters: [
                "name": name,
                "breed": breed,
                "sex": sex,
                "weight": weight,
                "birth": birth,
                "description": description,
                "amount": amount,
                "images": images,
                "cover_image": coverImage
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
    
    
    static func donateUpdate(
        id: Int,
        name: String,
        breed: Int,
        sex: Int,
        weight: Double,
        birth: String,
        description: String,
        amount: Int,
        images: [Int],
        coverImage: Int,
        completion: @escaping (Result<PetDonate, Error>) -> Void
    ) {
        NetworkManager.shared.doPatch(
            path: "/donate/update/\(id)",
            parameters: [
                "name": name,
                "breed": breed,
                "sex": sex,
                "weight": weight,
                "birth": birth,
                "description": description,
                "amount": amount,
                "images": images,
                "cover_image": coverImage
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
    
    
    static func stateUpdate(id: Int, state: Int, completion: @escaping (Result<Detail, Error>) -> Void
    ) {
        NetworkManager.shared.doPost(
            path: "/donate/stateUpdate/\(id)",
            parameters: ["state": state]
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
