//
//  Voucher.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/30/20.
//

import Foundation

final class Voucher: Codable, Identifiable {
    let voucherID: String
    let title: String
    let imageURL: String
    let discountDescription: String
    let beforeCost: Int
    let afterCost: Int
    
    enum VoucherKeys: String, CodingKey {
        case voucherID = "_id"
        case title
        case imageURL
        case discountDescription
        case beforeCost
        case afterCost
    }
    
    init(title: String,
         imageURL: String,
         discountDescription: String,
         beforeCost: Int,
         afterCost: Int) {
        voucherID = ""
        self.title = title
        self.imageURL = imageURL
        self.discountDescription = discountDescription
        self.beforeCost = beforeCost
        self.afterCost = afterCost
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: VoucherKeys.self)
        
        voucherID = try values.decode(String.self, forKey: .voucherID)
        title = try values.decode(String.self, forKey: .title)
        imageURL = try values.decode(String.self, forKey: .imageURL)
        discountDescription = try values.decode(String.self, forKey: .discountDescription)
        beforeCost = try values.decode(Int.self, forKey: .beforeCost)
        afterCost = try values.decode(Int.self, forKey: .afterCost)
    }
}
