//
//  BookHistoryViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/16/20.
//

import Foundation

class BookHistoryViewModel: ObservableObject {
    @Published var bookHistory: [BookedRoom] = []
    
    func getAllBookHistory() {
        MeetingRoomService.shared.getAllBookHistory { [weak self] bookedInfos in
            self?.bookHistory = bookedInfos.reversed()
        }
    }
    
    func getMeetingRoomInfo(of bookHistory: BookedRoom) -> MeetingRoom {
        let allMeetingRooms = MeetingRoomService.shared.getAllRoomInfos()
        guard let meetingRoom = allMeetingRooms.first(where: { $0.roomID == bookHistory.roomID }) else {
            return MeetingRoom(name: "Default", polycom: "Default", location: "Default", building: "Default", maxSeats: 10)
        }
        
        return meetingRoom
    }
}
