//
//  NetworkManager.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/7.
//

import Alamofire

typealias NetworkRequestCompletion = (Result<Data, Error>) -> Void


private let NetworkApiBaseUrl = "http://10.9.9.6:8000"

private let requestModifier: Session.RequestModifier = { $0.timeoutInterval = 5 }

class NetworkManager {
    static let shared = NetworkManager()
    var requestHeaders = HTTPHeaders()
    
    private init() {
        if let token = UserDefaults.standard.string(forKey: .token) {
            setToken(token)
        }
    }
    
    func setToken(_ token: String) -> Void {
        requestHeaders.add(name: "TOKEN", value: token)
    }
    
    func doGet(path: String, parameters: Parameters? = nil, completion: @escaping NetworkRequestCompletion) -> Void {
        AF.request(
            NetworkApiBaseUrl + path,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.queryString,
            headers: requestHeaders,
            requestModifier: requestModifier
        )
        .responseData { response in
            switch response.result {
            case let .success(data):
                let code = response.response?.statusCode ?? -1
                if code == 200 {
                    completion(.success(data))
                } else {
                    var domain = "错误"
                    if let data = response.data, let str = String(data: data, encoding: .utf8) {
                        domain = str
                    }
                    let error = NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey: "doGet错误"])
                    print(error)
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func doPost(path: String, parameters: Parameters? = nil, completion: @escaping NetworkRequestCompletion) -> Void {
        AF.request(
            NetworkApiBaseUrl + path,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.prettyPrinted,
            headers: requestHeaders,
            requestModifier: requestModifier
        )
        .responseData { response in
            switch response.result {
            case let .success(data):
                let code = response.response?.statusCode ?? -1
                if code == 200 || code == 201 {
                    completion(.success(data))
                } else {
                    var domain = "错误"
                    if let data = response.data, let str = String(data: data, encoding: .utf8) {
                        domain = str
                    }
                    let error = NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey: "doPost错误"])
                    print(error)
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func doPatch(path: String, parameters: Parameters? = nil, completion: @escaping NetworkRequestCompletion) -> Void {
        AF.request(
            NetworkApiBaseUrl + path,
            method: .patch,
            parameters: parameters,
            encoding: JSONEncoding.prettyPrinted,
            headers: requestHeaders,
            requestModifier: requestModifier
        )
        .responseData { response in
            switch response.result {
            case let .success(data):
                let code = response.response?.statusCode ?? -1
                if code == 200 || code == 201 {
                    completion(.success(data))
                } else {
                    var domain = "错误"
                    if let data = response.data, let str = String(data: data, encoding: .utf8) {
                        domain = str
                    }
                    let error = NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey: "doPatch错误"])
                    print(error)
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func doDelete(path: String, parameters: Parameters? = nil, completion: @escaping (Bool) -> Void) -> Void {
        AF.request(
            NetworkApiBaseUrl + path,
            method: .delete,
            parameters: parameters,
            encoding: URLEncoding.queryString,
            headers: requestHeaders,
            requestModifier: requestModifier
        )
        .responseData { response in
            if let code = response.response?.statusCode, code == 204 {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    
    func doUpload(path: String, multipartFormData: @escaping (MultipartFormData) -> Void, completion: @escaping NetworkRequestCompletion) -> Void {
        AF.upload(multipartFormData: multipartFormData, to:  NetworkApiBaseUrl + path).responseData { response in
            switch response.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(.failure(error))
            }
        }
    }
}
