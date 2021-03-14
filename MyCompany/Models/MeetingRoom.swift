//
//  MeetingRoom.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/2/20.
//

import Foundation

final class MeetingRoom: Codable, Identifiable {
    let roomID: String
    let name: String
    let polycom: String
    let location: String
    let building: String
    let maxSeats: Int
    
    init(name: String, polycom: String, location: String, building: String, maxSeats: Int) {
        roomID = ""
        self.name = name
        self.polycom = polycom
        self.location = location
        self.building = building
        self.maxSeats = maxSeats
    }
    
    enum RoomKey: String, CodingKey {
        case roomID = "_id"
        case name
        case polycom
        case location
        case building
        case maxSeats
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: RoomKey.self)
        
        roomID = try values.decode(String.self, forKey: .roomID)
        name = try values.decode(String.self, forKey: .name)
        polycom = try values.decode(String.self, forKey: .polycom)
        location = try values.decode(String.self, forKey: .location)
        building = try values.decode(String.self, forKey: .building)
        maxSeats = try values.decode(Int.self, forKey: .maxSeats)
    }
}
