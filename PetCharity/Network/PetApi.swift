//
//  PetApi.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/18.
//

import SwiftUI

class PetApi: NetworkApi {
    
    static func breedList(_ race: Int, completion: @escaping (Result<[PetBreed], Error>) -> Void) {
        NetworkManager.shared.doGet(
            path: "/pet/breed/list",
            parameters: ["race": race]
        ) { result in
            switch result {
            case let .success(data):
                completion(parsData(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func upload(image: UIImage, completion: @escaping (Result<PetImage, Error>) -> Void) {
        NetworkManager.shared.doUpload(path: "/pet/image/create") { multipartFormData in
            // 压缩质量 0.8
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                multipartFormData.append(imageData, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
            }
        } completion: { result in
            switch result {
            case let .success(data):
                completion(parsData(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
