//
//  CoinRequest.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/7/20.
//

import Foundation

class CoinRequest: Codable, Identifiable {
    let account: String
    let coinsPay: String?
    let date: Double
    let type: Int
    let storeName: String
    
    init(coinsPay: String, date: Double, type: Int, storeName: String, totalCoin: Int) {
        self.account = "TuanHA24"
        self.coinsPay = coinsPay
        self.date = date
        self.type = type
        self.storeName = storeName
    }
}
