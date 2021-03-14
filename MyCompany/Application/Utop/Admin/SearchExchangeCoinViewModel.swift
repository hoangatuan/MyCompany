//
//  SearchExchangeCoinViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/30/20.
//

import Foundation

class SearchExchangeCoinViewModel: ObservableObject {
    private var allRequests: [CoinRequest] = []
    @Published var displayRequests: [CoinRequest] = []
    @Published var onShowProgress: Bool = false
    @Published var onShowAlert: Bool = false
    
    var errorMessage: String = ""
    
    func getAllExchangeCoinRequests() {
        onShowProgress = true
        CoinService.shared.getAllCoinExchangeRequests { [weak self] requests in
            self?.allRequests = requests
            self?.filterListCoinRequest(by: "", startDate: Date(), endDate: Date())
            self?.onShowProgress = false
        } onError: { [weak self] error in
            self?.onShowProgress = false
            self?.errorMessage = error.rawValue
            self?.onShowAlert = true
        }
    }
    
    func filterListCoinRequest(by account: String, startDate: Date, endDate: Date) {
        if account.isEmpty {
            displayRequests = allRequests
        } else {
            displayRequests = allRequests.filter({ $0.account.contains(account) })
        }
        
        let startDateString = startDate.convertToFormat(format: .iso)
        let firstDayDate = toDate(isoDate: startDateString)?.timeIntervalSince1970 ?? 0
        
        let endDateString = endDate.convertToFormat(format: .iso)
        let endDayDate = Double(toDate(isoDate: endDateString)?.timeIntervalSince1970 ?? 0) + 24 * 3600
        
        displayRequests = displayRequests.filter({ $0.date >= firstDayDate && $0.date <= endDayDate })
    }
    
    private func toDate(isoDate: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        return formatter.date(from: isoDate)
    }
}
