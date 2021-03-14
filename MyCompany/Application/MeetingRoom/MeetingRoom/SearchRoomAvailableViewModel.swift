//
//  SearchRoomAvailableViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/12/20.
//

import Foundation

class SearchRoomAvailableViewModel: ObservableObject {
    var selectedDate: String
    var rooms: [MeetingRoom]
    @Published var bookedInfosFetch: [BookedRoom] = []
    
    init(selectedDate: String, rooms: [MeetingRoom], bookedInfos: [BookedRoom]) {
        self.selectedDate = selectedDate
        self.rooms = rooms
        self.bookedInfosFetch = bookedInfos
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadPage), name: NSNotification.Name.notificationHandlerReloadRoomAvailableView,
                                               object: nil)
    }
    
    @objc
    func reloadPage() {
        reloadData(selectedDate: selectedDate, currentBookedInfos: bookedInfosFetch)
    }
    
    func reloadData(selectedDate: String, currentBookedInfos: [BookedRoom]) {
        MeetingRoomService.shared.getAllBookedInfo(date: selectedDate) { [weak self] (bookedInfos) in
            self?.filterBookedInfos(allBookInfos: bookedInfos, currentBookedInfos: currentBookedInfos)
        }
    }
    
    private func filterBookedInfos(allBookInfos: [BookedRoom], currentBookedInfos: [BookedRoom]) {
        let currentBookedRoomIDs = rooms.map({ $0.roomID })
        let allRoomIDs = allBookInfos.map({ $0.roomID })
        
        var temp: [BookedRoom] = []
        for (index, data) in allRoomIDs.enumerated() {
            if currentBookedRoomIDs.contains(data) {
                temp.append(allBookInfos[index])
            }
        }
        
        bookedInfosFetch = temp
        
        NotificationCenter.default.post(name: NSNotification.Name.notificationShowAlertBookedResponse,
                                        object: nil)
    }
}
