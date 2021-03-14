//
//  BookingRoomViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/9/20.
//

import Foundation

class BookingRoomViewModel: ObservableObject {
    enum BookedResponse: String {
        case inputEmpty = "Vui lòng nhập trường Title"
        case alreadyBeenBooked = "Phòng không khả dụng trong khoảng thời gian này. Vui lòng thử lại"
        case bookFailed = "Book phòng thất bại. Vui lòng thử lại sau"
        case success = "Bạn đã book phòng họp thành công!"
    }
    
    @Published var onShowAlert: Bool = false
    @Published var onShowProgress: Bool = false
    
    var response: BookedResponse = .bookFailed
    
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showAlertBookedResponse), name: NSNotification.Name.notificationShowAlertBookedResponse,
                                               object: nil)
    }
    
    @objc
    func showAlertBookedResponse() {
        onShowProgress = false
        onShowAlert = true
    }
    
    func createNewBookRequest(roomID: String, date: String, startTime: String, endTime: String, title: String) {
        if title.trimmingCharacters(in: .whitespaces).isEmpty {
            response = .inputEmpty
            onShowAlert = true
            return
        }
        
        let startTimeDouble = Converter.convertTimeFromStringToDouble(timeValue: startTime)
        let endTimeDouble = Converter.convertTimeFromStringToDouble(timeValue: endTime)
        
        onShowProgress = true
        MeetingRoomService.shared.createBookRoomRequest(roomID: roomID, date: date,
                                                        startTime: String(startTimeDouble),
                                                        endTime: String(endTimeDouble),
                                                        title: title,
                                                        onStatus: { [weak self] statusCode in
                                                            self?.handleStatusCode(status: statusCode)
                                                        })
    }
    
    private func handleStatusCode(status: Int) {
        if status == 200 {
            response = .success
        } else if status == 444 { // Room has already been booked at that time
            response = .alreadyBeenBooked
        } else if status == 445 { // Booked failed. Server error
            response = .bookFailed
        }
        
        NotificationCenter.default.post(name: NSNotification.Name.notificationHandlerReloadRoomAvailableView,
                                        object: nil)
    }
}
