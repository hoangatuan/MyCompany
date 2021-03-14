//
//  MeetingRoomViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/4/20.
//

import Foundation

class MeetingRoomViewModel: ObservableObject {
    var bookedInfos: [BookedRoom] = []
    @Published var onFetchedBookedInfoSuccess: Bool = false
    @Published var onShowProgress: Bool = false
    
    var startTimeValues: [String] {
        return MeetingRoomService.shared.timeValues
    }
    
    @Published var endTimeValues: [String] = MeetingRoomService.shared.timeValues
    
    func getRoomIdByName(roomName: String) -> String {
        return MeetingRoomService.shared.getAllRoomInfos().filter({ $0.name == roomName })[0].roomID
    }
    
    func getAllRoomNameByLocation(location: String) -> [String] {
        var allRoomNames = ["All"]
        allRoomNames += MeetingRoomService.shared.getAllRoomByLocation(location: location).map({ $0.name })
        return allRoomNames
    }
    
    func getAllSelectRoomByName(name: String, location: String, isHavePolycom: Bool, minimumSeats: String) -> [MeetingRoom] {
        let allRooms = getAllRoomByLocation(location: location)
        let matchedRoom = allRooms.filter({ $0.name == name })
        var foundedRooms = matchedRoom.isEmpty ? allRooms : matchedRoom
        if isHavePolycom {
            foundedRooms = foundedRooms.filter({ $0.polycom != "N/A" })
        }
        
        if let minSeats = Int(minimumSeats) {
            foundedRooms = foundedRooms.filter({ $0.maxSeats >= minSeats })
        }
        
        return foundedRooms
    }
    
    func getAllRoomByLocation(location: String) -> [MeetingRoom] {
        return MeetingRoomService.shared.getAllRoomByLocation(location: location)
    }
    
    func getAllLocationDescription() -> [String] {
        return MeetingRoomService.shared.getAllLocationDescriptionValues()
    }
    
    func fetchAllMeetingRoomsFromServer() {
        MeetingRoomService.shared.getAllMeetingRoomInfo()
    }
    
    func generateTimesValue(startTime: String, endTime: String) -> [String] {
        let start = Converter.convertTimeFromStringToDouble(timeValue: startTime)
        let end = Converter.convertTimeFromStringToDouble(timeValue: endTime)
        
        let timeStringValues = stride(from: start, through: end, by: 0.5)
            .map({ Converter.convertTimeFromDoubleToString(timeValue: $0) })
        
        return timeStringValues
    }
    
    func fetchBookedInfo(of roomId: String, date: String) {
        onShowProgress = true
        MeetingRoomService.shared.getBookedInfo(of: roomId, date: date, completion: { [weak self] bookedInfos in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self?.onShowProgress = false
                self?.bookedInfos = bookedInfos
                self?.onFetchedBookedInfoSuccess = true
            })
        })
    }
    
    func fetchAllBookedInfo(date: String) {
        onShowProgress = true
        MeetingRoomService.shared.getAllBookedInfo(date: date) { [weak self] bookedInfos in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self?.onShowProgress = false
                self?.bookedInfos = bookedInfos
                self?.onFetchedBookedInfoSuccess = true
            })
        }
    }
}
