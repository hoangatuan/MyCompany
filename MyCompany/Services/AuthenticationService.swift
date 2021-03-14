//
//  AuthenticationService.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/10/20.
//

import Foundation

final class AuthenticationService {
    static let shared = AuthenticationService()
    
    enum AccountType: Int {
        case user = 200
        case admin = 222
    }
    
    enum LoginResult: String {
        case success
        case wrongURL = "Request failed. Please try again later"
        case wrongInput = "Wrong email or password. Please try again"
        case decodeFail = "Get user information failed. Please try again"
        case serverFail = "Request to server failed. Please try again later"
    }
    
    func login(rest: RestManager = RestManager(),
               username: String, password: String, completion: @escaping (LoginResult) -> Void) {
        let stringURL = RouterManager.LoginURL
        
        guard let url = URL(string: stringURL) else {
            completion(.wrongURL)
            return
        }
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        rest.httpBodyParameters.add(value: username.lowercased(), forkey: "email")
        
        let encryptPassword = DataProvider.sha256(password) ?? ""
        rest.httpBodyParameters.add(value: encryptPassword, forkey: "password")
        
        // TODOs: Change to API login
        rest.makeRequest(toURL: url, withHttpMethod: .post) { (result) in
            if result.error != nil {
                DispatchQueue.main.async {
                    completion(.serverFail)
                }
                return
            }
            
            guard let data = result.data else {
                DispatchQueue.main.async {
                    completion(.serverFail)
                }
                return
            }
            
            if let statusCode = result.response?.httpStatusCode {
                if statusCode == 444 { // Wrong username or password
                    completion(.wrongInput)
                    return
                }
                
                if statusCode == AccountType.user.rawValue {
                    do {
                        let employeeInfo = try JSONDecoder().decode(Employee.self, from: data)
                        DispatchQueue.main.async {
                            self.saveEmployeeNeccessaryInfo(employeeInfo: employeeInfo)
                            self.registerForApprovalRequest()
                            completion(.success)
                        }
                    } catch let error {
                        debugPrint("DECODE Employee Fail - Error: \(error)")
                        DispatchQueue.main.async {
                            completion(.decodeFail)
                        }
                    }
                }
                
                if statusCode == AccountType.admin.rawValue {
                    UserDataDefaults.shared.isAdministrator = true
                    DispatchQueue.main.async {
                        completion(.success)
                    }
                }
            }
        }
    }
    
    private func saveEmployeeNeccessaryInfo(employeeInfo: Employee) {
        UserDataDefaults.shared.employeeEmail = employeeInfo.email
        UserDataDefaults.shared.employeeID = employeeInfo.employeeID
        UserDataDefaults.shared.employeeAvatarImageUrl = employeeInfo.avatarImageURL
        UserDataDefaults.shared.employeeAccount = employeeInfo.account
        UserDataDefaults.shared.employeeName = employeeInfo.fullname
        UserDataDefaults.shared.isAdministrator = false
    }
    
    private func registerForApprovalRequest() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        appDelegate.registerForApproval()
    }
}
