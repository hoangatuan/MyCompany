//
//  OrderHistoryViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/22/20.
//

import Foundation

class OrderHistoryViewModel: ObservableObject {
    @Published var listBoughtVouchers: [BoughtVoucher]?
    @Published var onShowProgress: Bool = false
    @Published var onFetchVouchersFailed: Bool = false
    
    var errorMessage: String = ""
    
    func loadAllBoughtVouchers() {
        onShowProgress = true
        VoucherService.shared.getAllBoughtVouchers { [weak self] vouchers in
            self?.onShowProgress = false
            self?.listBoughtVouchers = vouchers
        } onError: { [weak self] error in
            self?.onShowProgress = false
            self?.onFetchVouchersFailed = true
            self?.errorMessage = error.rawValue
        }
    }
}
