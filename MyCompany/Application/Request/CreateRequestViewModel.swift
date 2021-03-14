//
//  CreateRequestViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/10/20.
//

import Foundation

class CreateRequestViewModel: ObservableObject {
    enum CreateRequestResponse {
        case invalidateInput, createSuccess
    }
    
    @Published var onShowAlert: Bool = false
    
    var response: CreateRequestResponse = .invalidateInput
    var invalidInputMessage: String = ""
    var allRequests: [Request] = []
    
    enum InvalidInput: String {
        case requestTypeEmpty = "Loại đơn không được để trống, vui lòng thử lại"
        case reasonEmpty = "Lí do tạo đơn không được để trống, vui lòng thử lại"
        case reasonDetailEmpty = "Vui lòng nhập trường Reason Detail"
        case noError
    }
    
    var requestType: [String] {
        get {
            return RequestService.shared.requestType
        }
    }
    
    var partialDay: [String] {
        get {
            return RequestService.shared.partialDay
        }
    }
    
    var reason: [String] {
        get {
            return RequestService.shared.reason
        }
    }
    
    func createNewRequest(requestType: String, startDate: String, endDate: String, partialDay: String, reason: String, reasonDetail: String) {
        let validInputResult = isAvailableInput(requestType: requestType, reason: reason, reasonDetail: reasonDetail)
        if validInputResult != .noError {
            invalidInputMessage = validInputResult.rawValue
            response = .invalidateInput
            onShowAlert = true
            return
        }
        
        RequestService.shared.createNewRequest(requestType: requestType,
                                               startDate: startDate, endDate: endDate,
                                               partialDay: partialDay,
                                               reason: reason, reasonDetail: reasonDetail,
                                               onStatus: { [weak self] status in
                                                self?.handleStatusCreateRequest(status: status)
                                               })
    }
    
    private func isAvailableInput(requestType: String, reason: String, reasonDetail: String) -> InvalidInput {
        if requestType == "Chọn loại đơn..." {
            return .requestTypeEmpty
        }
        
        if reason == "Chọn lí do..." {
            return .reasonEmpty
        }
        
        if reason == "Other" &&  reasonDetail.isEmpty {
            return .reasonDetailEmpty
        }
        
        return .noError
    }
    
    private func handleStatusCreateRequest(status: Int) {
        switch status {
        case 200:
            response = .createSuccess
            onShowAlert = true
        default:
            break
        }
    }
}
