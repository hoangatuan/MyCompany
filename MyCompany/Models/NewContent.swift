//
//  NewContent.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/25/20.
//

import Foundation

struct NewContent: Codable {
    let newID: String
    let contents: [Content]
    var comments: [Comment]
    
    init(newID: String,
         contents: [Content],
         comments: [Comment]) {
        self.newID = newID
        self.contents = contents
        self.comments = comments
    }
}
