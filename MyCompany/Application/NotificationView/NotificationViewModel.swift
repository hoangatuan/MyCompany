//
//  NotificationViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/2/20.
//

import Foundation

class NotificationViewModel: ObservableObject {
    @Published var listApprovedRequests: [Request] = []
    @Published var onShowAlert: Bool = false
    @Published var onShowProgress: Bool = false
    
    var errorMessage: String = ""
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleReloadNotificationView),
                                               name: NSNotification.Name.notificationReloadViewWhenRequestUpdated, object: nil)
    }
    
    func getAllApprovedRequest() {
        onShowProgress = true
        RequestService.shared.getAllApprovedRequest { [weak self] requests in
            self?.onShowProgress = false
            self?.listApprovedRequests = requests.sorted(by: { self!.compareTwoIsoDates(date1: $0.approveDate, date2: $1.approveDate) })
        } onError: { [weak self] error in
            self?.errorMessage = error.rawValue
            self?.onShowAlert = true
            self?.onShowProgress = false
        }
    }
    
    @objc
    func handleReloadNotificationView() {
        getAllApprovedRequest()
    }
    
    private func toDate(isoDate: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        return formatter.date(from: isoDate)
    }
    
    private func compareTwoIsoDates(date1: String, date2: String) -> Bool {
        let date1Double = toDate(isoDate: date1)?.timeIntervalSince1970 ?? 0
        let date2Double = toDate(isoDate: date2)?.timeIntervalSince1970 ?? 0
        
        return date1Double > date2Double
    }
}
