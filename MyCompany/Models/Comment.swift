//
//  Comment.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/25/20.
//

import Foundation

final class Comment: Codable, Identifiable {
    let employeeID: String
    let account: String
    let avatarURL: String
    let department: String
    let comment: String
    let createDate: Double
    
    init(account: String,
         avatarURL: String,
         department: String,
         comment: String,
         createDate: Double) {
        self.employeeID = ""
        self.account = account
        self.avatarURL = avatarURL
        self.department = department
        self.comment = comment
        self.createDate = createDate
    }
}
