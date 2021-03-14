//
//  Request.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/10/20.
//

import Foundation

struct Request: Codable, Identifiable, Equatable {
    let id = UUID()
    let requestID: String
    let employeeID: String
    let account: String
    let fullName: String
    let imageURL: String
    let requestType: String
    let startDate: String
    let endDate: String
    let partialDay: String
    let reason: String
    let reasonDetail: String
    let status: Int
    let approveDate: String
    let approveNote: String
    
    init(requestType: String,
         account: String,
         fullName: String,
         imageURL: String,
         startDate: String,
         endDate: String,
         partialDay: String,
         reason: String,
         reasonDetail: String,
         status: Int,
         approveDate: String,
         approveNote: String) {
        requestID = ""
        employeeID = ""
        self.account = account
        self.fullName = fullName
        self.imageURL = imageURL
        self.requestType = requestType
        self.startDate = startDate
        self.endDate = endDate
        self.partialDay = partialDay
        self.reason = reason
        self.reasonDetail = reasonDetail
        self.status = status
        self.approveDate = approveDate
        self.approveNote = approveNote
    }
    
    enum RequestKey: String, CodingKey {
        case requestID = "_id"
        case employeeID
        case account
        case fullName
        case imageURL
        case requestType
        case startDate
        case endDate
        case partialDay
        case reason
        case reasonDetail
        case status
        case approveDate
        case approveNote
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: RequestKey.self)
        
        requestID = try values.decode(String.self, forKey: .requestID)
        employeeID = try values.decode(String.self, forKey: .employeeID)
        account = try values.decode(String.self, forKey: .account)
        fullName = try values.decode(String.self, forKey: .fullName)
        imageURL = try values.decode(String.self, forKey: .imageURL)
        requestType = try values.decode(String.self, forKey: .requestType)
        startDate = try values.decode(String.self, forKey: .startDate)
        endDate = try values.decode(String.self, forKey: .endDate)
        partialDay = try values.decode(String.self, forKey: .partialDay)
        reason = try values.decode(String.self, forKey: .reason)
        reasonDetail = try values.decode(String.self, forKey: .reasonDetail)
        status = try values.decode(Int.self, forKey: .status)
        approveDate = try values.decode(String.self, forKey: .approveDate)
        approveNote = try values.decode(String.self, forKey: .approveNote)
    }
}
