//
//  VoucherService.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/1/20.
//

import Foundation

class VoucherService: ServiceProtocol {
    static let shared = VoucherService()
    
    func getListVouchers(at page: Int,
                         completion: @escaping ([Voucher], Int) -> Void,
                         onError: @escaping (RequestError) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.GetVouchersPerPage + "\(page)"
        
        guard let url = URL(string: stringURL) else {
            onError(.wrongURL)
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        performRequest(rest: rest, url: url, httpMethod: .get, completion: completion, onError: onError)
    }
    
    func getVoucherContent(of voucherId: String,
                           completion: @escaping (VoucherContent) -> Void,
                           onError: @escaping (RequestError) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.GetVoucherContent + voucherId
        
        guard let url = URL(string: stringURL) else {
            onError(.wrongURL)
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        performRequest(rest: rest, url: url, httpMethod: .get, completion: completion, onError: onError)
    }
    
    func buyVoucher(email: String, phone: String, address: String, note: String, cost: Int,
                    voucherTitle: String, voucherID: String, buyDate: String, imageURL: String, completion: @escaping () -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.BuyVoucher
        
        guard let url = URL(string: stringURL) else {
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        
        rest.httpBodyParameters.add(value: UserDataDefaults.shared.employeeID, forkey: "employeeID")
        rest.httpBodyParameters.add(value: email, forkey: "email")
        rest.httpBodyParameters.add(value: phone, forkey: "phone")
        rest.httpBodyParameters.add(value: address, forkey: "address")
        rest.httpBodyParameters.add(value: note, forkey: "note")
        rest.httpBodyParameters.add(value: String(cost), forkey: "cost")
        rest.httpBodyParameters.add(value: voucherID, forkey: "voucherID")
        rest.httpBodyParameters.add(value: voucherTitle, forkey: "voucherTitle")
        rest.httpBodyParameters.add(value: imageURL, forkey: "imageURL")
        rest.httpBodyParameters.add(value: buyDate, forkey: "buyDate")
        
        rest.makeRequest(toURL: url, withHttpMethod: .post, completion: { results in
            if results.error != nil {
                print("Error: \(results.error)")
                return
            }
            
            DispatchQueue.main.async {
                completion()
            }
        })
    }
    
    func getAllBoughtVouchers(completion: @escaping ([BoughtVoucher]) -> Void,
                              onError: @escaping (RequestError) -> Void) {
        let rest = RestManager()
        let stringURL = RouterManager.GetBoughtVoucherHistory + UserDataDefaults.shared.employeeID
        
        guard let url = URL(string: stringURL) else {
            onError(.wrongURL)
            return
        }
        
        rest.requestHttpHeaders.add(value: "application/json", forkey: "Content-Type")
        performRequest(rest: rest, url: url, httpMethod: .get, completion: completion, onError: onError)
    }
}
