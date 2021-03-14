//
//  MeetingRoomDetailViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 1/16/21.
//

import Foundation

class MeetingRoomDetailViewModel: ObservableObject {
    var bookedInfos: [BookedRoom] = []
    @Published var onFetchedBookedInfoSuccess: Bool = false
    @Published var onShowProgress: Bool = false
    
    func getAllTimesValue() -> [String] {
        MeetingRoomService.shared.timeValues
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
}
