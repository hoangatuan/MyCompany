//
//  BusService.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/20/20.
//

import Foundation

final class BusService {
    static let shared = BusService()
    
    func getAllBusInfo(completion: @escaping ([BusInfo]?) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.GetBusInfos
        
        guard let url = URL(string: stringURL) else {
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        rest.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            if results.error != nil {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            guard let data = results.data else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do {
                let busInfos = try JSONDecoder().decode([BusInfo].self, from: data)
                DispatchQueue.main.async {
                    completion(busInfos)
                }
            } catch let error {
                debugPrint("Decode Failed - BusInfo - Error: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
