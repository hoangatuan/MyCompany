//
//  BoughtVoucher.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/22/20.
//

import Foundation

class BoughtVoucher: Codable, Identifiable {
    let voucherID: String
    let email: String
    let phone: String
    let address: String
    let note: String
    let cost: Int
    let voucherTitle: String
    let buyDate: String
    let imageURL: String
    let status: Int
    
    init(email: String,
         phone: String,
         address: String,
         note: String,
         cost: Int,
         voucherTitle: String,
         buyDate: String,
         imageURL: String,
         status: Int) {
        voucherID = ""
        self.email = email
        self.phone = phone
        self.address = address
        self.note = note
        self.cost = cost
        self.voucherTitle = voucherTitle
        self.buyDate = buyDate
        self.imageURL = imageURL
        self.status = status
    }
}
