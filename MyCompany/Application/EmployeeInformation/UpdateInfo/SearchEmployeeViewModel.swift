//
//  SearchEmployeeViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/29/20.
//

import Foundation

class SearchEmployeeViewModel: ObservableObject {
    @Published var employeeDatasToPresent: [Employee] = []
    @Published var httpStatusCodeFetched: Int = 200
    @Published var onFetchedFailed: Bool = false
    @Published var onShowProgress: Bool = true
    
    var selectedEmployeeInfo: Employee = Employee()
    
    var pageFetched: Int = 0
    var errorMessage: String = ""
    var allEmployessInfoFetched: [Employee] = []
    
    func searchEmployeeByAccount(account: String) {
        if account == "" {
            employeeDatasToPresent = allEmployessInfoFetched
            return
        }

        EmployeeService.shared.getEmployeeInfosByAccount(account: account) { [weak self] employees in
            self?.employeeDatasToPresent = employees
        } onError: { error in
            
        }
    }
    
    func getAllEmployeeInfoPerPage() {
        onShowProgress = true
        EmployeeService.shared.getAllEmployeeInfo(at: pageFetched + 1) { [weak self] (employeeInfo, status) in
            self?.onShowProgress = false
            self?.httpStatusCodeFetched = status
            self?.pageFetched += 1
            self?.employeeDatasToPresent += employeeInfo
            self?.allEmployessInfoFetched = self?.employeeDatasToPresent ?? []
        } onError: { [weak self] error in
            self?.onShowProgress = false
            self?.onFetchedFailed = true
            self?.errorMessage = error.rawValue
        }
    }
}
