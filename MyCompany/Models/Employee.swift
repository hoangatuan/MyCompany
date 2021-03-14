//
//  Employee.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/10/20.
//

import Foundation

final class Employee: Codable, Identifiable {
    var employeeID: String
    var fullname: String
    let account: String
    let dob: String
    let gender: String
    let jobFamily: String
    let nationalID: String
    var address: String
    var telephone: String
    var email: String
    var jobRank: String
    let department: String
    var contractStartDate: String
    var contractEndDate: String
    var avatarImageURL: String
    
    enum EmployeeKeys: String, CodingKey {
        case employeeID = "_id"
        case fullname
        case account
        case dob
        case gender
        case jobFamily
        case nationalID
        case address
        case telephone
        case email
        case jobRank
        case department
        case contractStartDate
        case contractEndDate
        case avatarImageURL
    }
    
    init() {
        employeeID = ""
        fullname = ""
        account = ""
        dob = ""
        gender = ""
        jobFamily = ""
        nationalID = ""
        address = ""
        telephone = ""
        email = ""
        jobRank = ""
        department = ""
        contractStartDate = ""
        contractEndDate = ""
        avatarImageURL = ""
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: EmployeeKeys.self)
        
        employeeID = try values.decode(String.self, forKey: .employeeID)
        fullname = try values.decode(String.self, forKey: .fullname)
        account = try values.decode(String.self, forKey: .account)
        dob = try values.decode(String.self, forKey: .dob)
        gender = try values.decode(String.self, forKey: .gender)
        jobFamily = try values.decode(String.self, forKey: .jobFamily)
        nationalID = try values.decode(String.self, forKey: .nationalID)
        address = try values.decode(String.self, forKey: .address)
        telephone = try values.decode(String.self, forKey: .telephone)
        email = try values.decode(String.self, forKey: .email)
        jobRank = try values.decode(String.self, forKey: .jobRank)
        department = try values.decode(String.self, forKey: .department)
        contractStartDate = try values.decode(String.self, forKey: .contractStartDate)
        contractEndDate = try values.decode(String.self, forKey: .contractEndDate)
        avatarImageURL = try values.decode(String.self, forKey: .avatarImageURL)
    }
}

class EmployeePresentData: Identifiable, ObservableObject {
    let title: String
    let editStyle: EditStyle
    @Published var content: String
    
    init(title: String, content: String, editStyle: EditStyle = .none) {
        self.title = title
        self.content = content
        self.editStyle = editStyle
    }
}
