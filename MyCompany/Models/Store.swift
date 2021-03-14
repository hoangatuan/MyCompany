//
//  Store.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/7/20.
//

import Foundation

class Store: Codable {
    let storeID: String
    let name: String
    
    enum StoreKeys: String, CodingKey {
        case storeID = "_id"
        case name
    }
    
    init(name: String) {
        storeID = ""
        self.name = name
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: StoreKeys.self)
        
        storeID = try values.decode(String.self, forKey: .storeID)
        name = try values.decode(String.self, forKey: .name)
    }
}
