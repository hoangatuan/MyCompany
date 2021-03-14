//
//  Bus.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/20/20.
//

import Foundation

final class BusInfo: Codable, Identifiable {
    let numbOrder: String
    let name: String
    let pickTime: String
    let dropTime: String
    let route: [BusRoute]
    let hotline: String
    let account: String
    let telephone: String
    let lat: Double
    let long: Double
    
    init(numbOrder: String,
         name: String,
         pickTime: String,
         dropTime: String,
         route: [BusRoute],
         hotline: String,
         account: String,
         telephone: String) {
        self.numbOrder = numbOrder
        self.name = name
        self.pickTime = pickTime
        self.dropTime = dropTime
        self.route = route
        self.hotline = hotline
        self.account = account
        self.telephone = telephone
        lat = 0.0
        long = 0.0
    }
}
