//
//  RequestService.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/10/20.
//

import Foundation

final class RequestService: ServiceProtocol {
    static let shared = RequestService()
    let requestType: [String] = ["Work from home (Covid19)",
                                 "Đi muộn",
                                 "Về sớm",
                                 "Nghỉ phép",
                                 "Nghỉ bù",
                                 "Nghỉ không lương",
                                 "Nghỉ ốm có giấy bệnh viện",
                                 "Nghỉ kết hôn",
                                 "Nghỉ sinh đẻ"]
    
    let partialDay: [String] = ["Buổi sáng",
                                "Buổi chiều",
                                "Cả ngày"]
    
    let reason: [String] = ["Chăm sóc người nhà ốm",
                            "Lý do sức khỏe cá nhân",
                            "Ở nhà trông con không có người giúp",
                            "Đi học",
                            "Đưa đón con đi học",
                            "Other"]
    
    func getAllRequests(completion: @escaping ([Request]) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.GetAllRequest + UserDataDefaults.shared.employeeID
        
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
                let allRequests = try JSONDecoder().decode([Request].self, from: data)
                DispatchQueue.main.async {
                    completion(allRequests)
                }
            } catch let error {
                debugPrint("Decode Request Failed - Error: \(error)")
            }
        }
    }
    
    func getAllEmployeesRequests(completion: @escaping ([Request]) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.GetAllEmployeesRequest
        
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
                let allRequests = try JSONDecoder().decode([Request].self, from: data)
                DispatchQueue.main.async {
                    completion(allRequests)
                }
            } catch let error {
                debugPrint("Decode All Request Failed - Error: \(error)")
            }
        }
    }
    
    func createNewRequest(requestType: String, startDate: String, endDate: String, partialDay: String, reason: String, reasonDetail: String, onStatus: @escaping (Int) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.CreateNewRequest
        
        guard let url = URL(string: stringURL) else {
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        
        rest.httpBodyParameters.add(value: UserDataDefaults.shared.employeeID, forkey: "employeeID")
        rest.httpBodyParameters.add(value: requestType, forkey: "requestType")
        rest.httpBodyParameters.add(value: startDate, forkey: "startDate")
        rest.httpBodyParameters.add(value: endDate, forkey: "endDate")
        rest.httpBodyParameters.add(value: partialDay, forkey: "partialDay")
        rest.httpBodyParameters.add(value: reason, forkey: "reason")
        rest.httpBodyParameters.add(value: reasonDetail, forkey: "reasonDetail")
        
        rest.makeRequest(toURL: url, withHttpMethod: .post, completion: { results in
            guard let statusCode = results.response?.httpStatusCode else {
                return
            }
            
            DispatchQueue.main.async {
                onStatus(statusCode)
            }
        })
    }
    
    func approveRequest(requestID: String, approveStatus: String, approveNote: String, completion: @escaping (Request) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.ApproveRequest
        let approveDate = Date().convertToFormat(format: .iso)
        
        guard let url = URL(string: stringURL) else {
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        
        rest.httpBodyParameters.add(value: requestID, forkey: "requestID")
        rest.httpBodyParameters.add(value: approveStatus, forkey: "approveStatus")
        rest.httpBodyParameters.add(value: approveDate, forkey: "approveDate")
        rest.httpBodyParameters.add(value: approveNote, forkey: "approveNote")
        
        rest.makeRequest(toURL: url, withHttpMethod: .put, completion: { results in
            if results.error != nil {
                return
            }
            
            guard let data = results.data else {
                return
            }
            
            do {
                let request = try JSONDecoder().decode(Request.self, from: data)
                DispatchQueue.main.async {
                    completion(request)
                }
            } catch let error {
                debugPrint("Approve Request Failed - Error: \(error)")
            }
        })
    }
    
    func getAllApprovedRequest(completion: @escaping ([Request]) -> Void, onError: @escaping (RequestError) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.GetAllApprovedRequest + UserDataDefaults.shared.employeeID
        
        guard let url = URL(string: stringURL) else {
            onError(.wrongURL)
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        performRequest(rest: rest, url: url, httpMethod: .get, completion: completion, onError: onError)
    }
    
    func searchRequestByAccount(account: String,
                                completion: @escaping ([Request]) -> Void,
                                onError: @escaping (RequestError) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.SearchRequestByAccount + "\(account)"
        
        guard let url = URL(string: stringURL) else {
            onError(.wrongURL)
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        performRequest(rest: rest, url: url, httpMethod: .get, completion: completion, onError: onError)
    }
}
