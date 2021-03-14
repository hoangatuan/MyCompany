//
//  RouterURLManager.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/18/20.
//

import Foundation

enum RouterManager {
//    "localhost"
    static let IPADDRESS: String = "203.171.21.114"
    
    // Account
    static let LoginURL = "http://\(IPADDRESS):3000/accounts/login"
    static let GetTotalMoneyURL = "http://\(IPADDRESS):3000/accounts/totalMoney?employeeID="
    
    // Employee
    static let GetEmployeeInfoURL = "http://\(IPADDRESS):3000/employee/getInfo/"
    static let GetAllEmployeeInfoURL = "http://\(IPADDRESS):3000/employee?page="
    static let GetEmployeeInfoByAccount = "http://\(IPADDRESS):3000/employee/search?account="
    static let GetEmployeeAvatarURL = "http://\(IPADDRESS):3000/"
    static let UpdateAvatarURL = "http://\(IPADDRESS):3000/employee/updateAvatar"
    static let UpdateEmployeeInfo = "http://\(IPADDRESS):3000/employee/updateInfo"
    
    // News
    static let GetNewsImage = "http://\(IPADDRESS):3000/newsImage/"
    static let GetNewsPerPage = "http://\(IPADDRESS):3000/news?page="
    static let LikeNewURL = "http://\(IPADDRESS):3000/news/like"
    static let DislikeNewURL = "http://\(IPADDRESS):3000/news/dislike"
    static let SearchNewByTitle = "http://\(IPADDRESS):3000/news/search?title="
    
    // Contents
    static let GetContentOfNew = "http://\(IPADDRESS):3000/contents/"
    static let GetContentImage = "http://\(IPADDRESS):3000/newContentImages/"
    static let PostCommentURL = "http://\(IPADDRESS):3000/contents/postComment"
    
    // Bus
    static let GetBusInfos = "http://\(IPADDRESS):3000/businfos"
    static let GetBusImage = "http://\(IPADDRESS):3000/busImage/"
    
    // Voucher
    static let GetVouchersPerPage = "http://\(IPADDRESS):3000/vouchers?page="
    static let GetVoucherContent = "http://\(IPADDRESS):3000/vouchers/"
    static let GetVoucherDescriptionImage = "http://\(IPADDRESS):3000/voucherDescriptionImages/"
    static let GetVoucherImage = "http://\(IPADDRESS):3000/voucherImages/"
    static let GetBoughtVoucherHistory = "http://\(IPADDRESS):3000/boughtvouchers/"
    static let BuyVoucher = "http://\(IPADDRESS):3000/boughtvouchers/buy"
    
    // MeetingRoom
    static let GetAllMeetingRoomInfo = "http://\(IPADDRESS):3000/meetingrooms/"
    static let GetBookedRoomInfo = "http://\(IPADDRESS):3000/booked/search?roomId="
    static let GetAllBookedRoomInfo = "http://\(IPADDRESS):3000/booked/searchAll?date="
    static let CreateBookRequest = "http://\(IPADDRESS):3000/booked/bookingRoom"
    static let GetBookHistory = "http://\(IPADDRESS):3000/booked/history?employeeID="
    
    // Request
    static let GetAllRequest = "http://\(IPADDRESS):3000/request?employeeID="
    static let CreateNewRequest = "http://\(IPADDRESS):3000/request/create"
    static let ApproveRequest = "http://\(IPADDRESS):3000/request/approve"
    static let GetAllEmployeesRequest = "http://\(IPADDRESS):3000/request/getAll"
    static let SearchRequestByAccount = "http://\(IPADDRESS):3000/request/searchAccount?account="
    static let GetAllApprovedRequest = "http://\(IPADDRESS):3000/request/getApprovedRequest?employeeID="
    
    // Coin
    static let GetStoreName = "http://\(IPADDRESS):3000/restaurent?restaurentID="
    static let UpdateCoinUrl = "http://\(IPADDRESS):3000/purchaseRequest/update"
    
    static let GetExchangeRequestByAccountURL = "http://\(IPADDRESS):3000/purchaseRequest/getExchangeRequestByAccount?account="
    static let GetAllExchangeRequests = "http://\(IPADDRESS):3000/purchaseRequest/getAllExchangeRequests"
}
