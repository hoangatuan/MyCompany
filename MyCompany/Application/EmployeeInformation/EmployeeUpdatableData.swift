//
//  EmployeeUpdatableData.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/29/20.
//

import Foundation

class EmployeeUpdatableData {
    let employeeID: String
    let address: String
    let telephone: String
    let email: String
    let jobRank: String
    let contractStartDate: String
    let contractEndDate: String
    
    init(employeeID: String, address: String, telephone: String, email: String, jobRank: String, contractStartDate: String, contractEndDate: String) {
        self.employeeID = employeeID
        self.address = address
        self.telephone = telephone
        self.email = email
        self.jobRank = jobRank
        self.contractStartDate = contractStartDate
        self.contractEndDate = contractEndDate
    }
}
