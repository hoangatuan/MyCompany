//
//  VoucherContent.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/1/20.
//

import Foundation

final class VoucherContent: Codable {
    let voucherID: String
    let imageDescriptionURL: [String]
    let contents: [Content]
    
    init(imageDescriptionURL: [String], voucherID: String, contents: [Content]) {
        self.imageDescriptionURL = imageDescriptionURL
        self.voucherID = voucherID
        self.contents = contents
    }
}
