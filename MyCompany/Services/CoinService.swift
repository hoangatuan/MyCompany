//
//  CoinService.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/8/20.
//

import Foundation

final class CoinService: ServiceProtocol {
    static let shared = CoinService()
    
    func getStore(storeID: String, completion: @escaping (Store) -> Void, onError: @escaping (RequestError) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.GetStoreName + storeID
        
        guard let url = URL(string: stringURL) else {
            onError(.wrongURL)
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        rest.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            if results.error != nil {
                onError(.connectToServerFailed)
                return
            }
            
            guard let data = results.data else {
                onError(.serverFail)
                return
            }
            
            do {
                let store = try JSONDecoder().decode(Store.self, from: data)
                DispatchQueue.main.async {
                    completion(store)
                }
            } catch let error {
                onError(.decodeFail)
                debugPrint("Decode Store Failed - Error: \(error)")
            }
        }
    }
    
    func updateCoin(storeID: String, type: String, coins: String,
                    completion: @escaping (CoinRequest) -> Void,
                    statusCode: @escaping (Int) -> Void,
                    onError: @escaping (RequestError) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.UpdateCoinUrl
        
        guard let url = URL(string: stringURL) else {
            onError(.wrongURL)
            return
        }
        let date = Date().timeIntervalSince1970
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        
        rest.httpBodyParameters.add(value: UserDataDefaults.shared.employeeID, forkey: "employeeID")
        rest.httpBodyParameters.add(value: type, forkey: "type")
        rest.httpBodyParameters.add(value: "\(date)", forkey: "date")
        rest.httpBodyParameters.add(value: coins, forkey: "coins")
        rest.httpBodyParameters.add(value: storeID, forkey: "storeID")
        
        rest.makeRequest(toURL: url, withHttpMethod: .post) { (results) in
            if results.error != nil {
                onError(.connectToServerFailed)
                return
            }
            
            if results.response?.httpStatusCode == 444 {
                DispatchQueue.main.async {
                    statusCode(444)
                }
                
                return
            }
            
            guard let data = results.data else {
                onError(.serverFail)
                return
            }
            
            do {
                let coinRequest = try JSONDecoder().decode(CoinRequest.self, from: data)
                DispatchQueue.main.async {
                    completion(coinRequest)
                }
            } catch let error {
                onError(.decodeFail)
                debugPrint("Decode Coin Request Failed - Error: \(error)")
            }
        }
    }
    
    func getTotalCoin(completion: @escaping (Int) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.GetTotalMoneyURL + UserDataDefaults.shared.employeeID
        
        guard let url = URL(string: stringURL) else {
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        
        rest.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            if results.error != nil {
                return
            }
            
            guard let data = results.data else {
                return
            }
            
            do {
                let totalCoin = try JSONDecoder().decode(Int.self, from: data)
                DispatchQueue.main.async {
                    completion(totalCoin)
                }
            } catch let error {
                debugPrint("Decode Total Coin Failed - Error: \(error)")
            }
        }
    }
    
    func getAllCoinExchangeRequests(completion: @escaping ([CoinRequest]) -> Void,
                                    onError: @escaping (RequestError) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.GetAllExchangeRequests
        
        guard let url = URL(string: stringURL) else {
            onError(.wrongURL)
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        performRequest(rest: rest, url: url, httpMethod: .get, completion: completion, onError: onError)
    }
}
