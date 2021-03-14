//
//  BookedRoom.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/7/20.
//

import Foundation

final class BookedRoom: Codable {
    let employeeID: String
    let account: String
    let roomID: String
    let date: String
    let startTime: Double
    let endTime: Double
    let title: String
    
    init(employeeID: String, account: String, roomID: String, date: String, startTime: Double, endTime: Double, title: String) {
        self.employeeID = employeeID
        self.account = account
        self.roomID = roomID
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.title = title
    }
}
