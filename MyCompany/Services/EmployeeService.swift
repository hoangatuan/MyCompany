//
//  EmployeeService.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/11/20.
//

import UIKit

final class EmployeeService: ServiceProtocol {
    static let shared = EmployeeService()
    
    func getAllEmployeeInfo(at page: Int, completion: @escaping ([Employee], Int) -> Void,
                            onError: @escaping (RequestError) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.GetAllEmployeeInfoURL + String(page)
        
        guard let url = URL(string: stringURL) else {
            onError(.wrongURL)
            return
        }
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        performRequest(rest: rest, url: url, httpMethod: .get, completion: completion, onError: onError)
    }
    
    func getEmployeeInfosByAccount(account: String, completion: @escaping ([Employee]) -> Void,
                                   onError: @escaping (RequestError) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.GetEmployeeInfoByAccount + account
        
        guard let url = URL(string: stringURL) else {
            onError(.wrongURL)
            return
        }
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        performRequest(rest: rest, url: url, httpMethod: .get, completion: completion, onError: onError)
    }
    
    func getEmployeeInfo(completion: @escaping (Employee?) -> Void,
                         onError: @escaping (RequestError) -> Void) {
        let currentEmail = UserDataDefaults.shared.employeeEmail
        let rest = RestManager()
        let stringURL = RouterManager.GetEmployeeInfoURL + currentEmail
        
        guard let url = URL(string: stringURL) else {
            completion(nil)
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        performRequest(rest: rest, url: url, httpMethod: .get, completion: completion, onError: onError)
    }
    
    func updateAvatarImage(with image: UIImage, onSuccess: @escaping (Bool) -> Void) {
        let filename = "avatar.png"

        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString

        let fieldName = "employeeID"
        let fieldValue = UserDataDefaults.shared.employeeID

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: URL(string: RouterManager.UpdateAvatarURL)!)
        urlRequest.httpMethod = "PUT"

        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()

        // Add the reqtype field and its value to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(fieldName)\"\r\n\r\n".data(using: .utf8)!)
        data.append("\(fieldValue)".data(using: .utf8)!)
        
        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"avatarImage\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)

        // End the raw http request data, note that there is 2 extra dash ("-") at the end, this is to indicate the end of the data
        // According to the HTTP 1.1 specification https://tools.ietf.org/html/rfc7230
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if(error != nil){
                print("Update Avatar Image Failed with Error: \(error!.localizedDescription)")
                DispatchQueue.main.async {
                    onSuccess(false)
                }
                return
            }
            
            guard let responseData = responseData else {
                print("Update Avatar Image Failed: No Response Data")
                DispatchQueue.main.async {
                    onSuccess(false)
                }
                return
            }
            
            DispatchQueue.main.async {
                print("Update Avatar Image Successfully to path: \(String(data: responseData, encoding: .utf8))")
                onSuccess(true)
            }
        }).resume()
    }
    
    func updateEmployeeInfo(with data: EmployeeUpdatableData, completion: @escaping (Employee) -> Void, onError: @escaping (RequestError) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.UpdateEmployeeInfo
        
        guard let url = URL(string: stringURL) else {
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        rest.httpBodyParameters.add(value: data.employeeID, forkey: "employeeID")
        rest.httpBodyParameters.add(value: data.address, forkey: "address")
        rest.httpBodyParameters.add(value: data.telephone, forkey: "telephone")
        rest.httpBodyParameters.add(value: data.email, forkey: "email")
        rest.httpBodyParameters.add(value: data.jobRank, forkey: "jobRank")
        rest.httpBodyParameters.add(value: data.contractStartDate, forkey: "contractStartDate")
        rest.httpBodyParameters.add(value: data.contractEndDate, forkey: "contractEndDate")
        
        performRequest(rest: rest, url: url, httpMethod: .put, completion: completion, onError: onError)
    }
}
