//
//  MeetingRoomSearchViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/3/20.
//

import Foundation

class MeetingRoomSearchViewModel: ObservableObject {
    @Published var matchedRoom: [MeetingRoom] = []
    
    func searchForMeetingRoom(with name: String) {
        let processedName: String = name.lowercased()
            .trimmingCharacters(in: .whitespaces)
            .folding(options: .diacriticInsensitive, locale: .current)
            
        let continueProcess = processedName.map({ char -> Character in
            if char == "đ" {
               return "d"
            }
           
           return char
        })
        let continueProcessString = String(continueProcess)
        
        matchedRoom = MeetingRoomService.shared.getAllRoomInfos()
            .filter({ getRoomName(room: $0).contains(continueProcessString)
        })
    
        print("match room count = \(matchedRoom.count)")
    }
    
    private func getRoomName(room: MeetingRoom) -> String {
        let processName = room.name.lowercased()
            .folding(options: .diacriticInsensitive, locale: .current)
            .map({ char -> Character in
                if char == "đ" {
                    return "d"
                }
                
                return char
            })
        
        return String(processName)
    }
}
