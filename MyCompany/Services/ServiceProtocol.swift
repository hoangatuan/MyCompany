//
//  ServiceProtocol.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/20/20.
//

import Foundation

protocol ServiceProtocol {
    func performRequest<T: Codable>(rest: RestManager, url: URL, httpMethod: RestManager.HttpMethod, completion: @escaping (T) -> Void, onError: @escaping (RequestError) -> Void)
    func performRequest<T: Codable>(rest: RestManager, url: URL, httpMethod: RestManager.HttpMethod, completion: @escaping (T, Int) -> Void, onError: @escaping (RequestError) -> Void)
}

extension ServiceProtocol {
    func performRequest<T: Codable>(rest: RestManager,
                                url: URL,
                                httpMethod: RestManager.HttpMethod,
                                completion: @escaping (T) -> Void, onError: @escaping (RequestError) -> Void) {
        rest.makeRequest(toURL: url, withHttpMethod: httpMethod) { (result) in
            if result.error != nil {
                DispatchQueue.main.async {
                    onError(.connectToServerFailed)
                }
                return
            }
            
            guard let data = result.data else {
                DispatchQueue.main.async {
                    onError(.serverFail)
                }
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(object)
                }
            } catch let error {
                debugPrint("DECODE Fail - Error: \(error)")
                DispatchQueue.main.async {
                    onError(.decodeFail)
                }
            }
        }
    }
    
    func performRequest<T: Codable>(rest: RestManager,
                                    url: URL, httpMethod: RestManager.HttpMethod,
                                    completion: @escaping (T, Int) -> Void,
                                    onError: @escaping (RequestError) -> Void) {
        rest.makeRequest(toURL: url, withHttpMethod: .get) { (result) in
            if result.error != nil {
                DispatchQueue.main.async {
                    onError(.connectToServerFailed)
                }
            }
            
            guard let httpStatus = result.response?.httpStatusCode,
                  let data = result.data else {
                DispatchQueue.main.async {
                    onError(.serverFail)
                }
                
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(object, httpStatus)
                }
            } catch let error {
                debugPrint("DECODE Fail With StatusCode - Error: \(error)")
                DispatchQueue.main.async {
                    onError(.decodeFail)
                }
            }
        }
    }
}

class BaseService: ServiceProtocol {
    
}
