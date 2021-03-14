//
//  AllRequestsViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/11/20.
//

import Foundation

class AllRequestsViewModel: ObservableObject {
    @Published var listAllRequests: [Request] = []
    @Published var onShowProgress: Bool = false
    
    func getAllRequests() {
        onShowProgress = true
        RequestService.shared.getAllRequests { [weak self] requests in
            self?.onShowProgress = false
            self?.listAllRequests = requests.reversed()
        }
    }
    
    func getAllEmployeesRequests() {
        onShowProgress = true
        RequestService.shared.getAllEmployeesRequests(completion: { [weak self] requests in
            self?.onShowProgress = false
            self?.listAllRequests = requests.filter({ $0.status == 0 })
        })
    }
    
    /*
     Can not use mutating func and change variable inside a closure -> Use view model to change and view observe it
     https://stackoverflow.com/questions/58327013/swift-5-whats-escaping-closure-captures-mutating-self-parameter-and-how-t
     */
}
