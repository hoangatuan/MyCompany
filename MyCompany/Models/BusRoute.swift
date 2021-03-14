//
//  BusRoute.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/20/20.
//

import Foundation

final class BusRoute: Codable, Identifiable {
    let routeID: String
    let time: String
    let description: String
    let imageURL: String
    let isStartPoint: Bool
    let isEndPoint: Bool
    let isGoHomePoint: Bool
    
    init(time: String,
         description: String,
         imageURL: String,
         isStartPoint: Bool,
         isEndPoint: Bool,
         isGoHomePoint: Bool) {
        routeID = ""
        self.time = time
        self.description = description
        self.imageURL = imageURL
        self.isStartPoint = isStartPoint
        self.isEndPoint = isEndPoint
        self.isGoHomePoint = isGoHomePoint
    }
}
