//
//  New.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/18/20.
//

import Foundation

enum NewType: Int {
    case new = 0
    case announcement
    
    var description: String {
        switch self {
        case .new:
            return "News"
        case .announcement:
            return "Announcements"
        }
    }
}

struct New: Codable, Equatable {
    let id = UUID()
    let newID: String
    let title: String
    let imageURL: String
    let createDate: Double
    let type: Int
    let likes: [String]
    let dislikes: [String]
    let comments: Int
    
    enum NewKeys: String, CodingKey {
        case newID = "_id"
        case title
        case imageURL
        case createDate
        case type
        case likes
        case dislikes
        case comments
    }
    
    init(newID: String,
         title: String,
         imageURL: String,
         createDate: Double,
         type: Int,
         likes: [String],
         dislikes: [String],
         comments: Int) {
        self.newID = newID
        self.title = title
        self.imageURL = imageURL
        self.createDate = createDate
        self.type = type
        self.likes = likes
        self.dislikes = dislikes
        self.comments = comments
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: NewKeys.self)
        
        newID = try values.decode(String.self, forKey: .newID)
        title = try values.decode(String.self, forKey: .title)
        imageURL = try values.decode(String.self, forKey: .imageURL)
        createDate = try values.decode(Double.self, forKey: .createDate)
        type = try values.decode(Int.self, forKey: .type)
        likes = try values.decode([String].self, forKey: .likes)
        dislikes = try values.decode([String].self, forKey: .dislikes)
        comments = try values.decode(Int.self, forKey: .comments)
    }
}

extension New: Identifiable {
    
}
