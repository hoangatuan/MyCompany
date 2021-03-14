//
//  VouchersViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/1/20.
//

import Foundation
import Combine

class VouchersViewModel: ObservableObject {
    var pageFetched: Int = 0
    var errorMessage = ""
    
    @Published var listItemsToDisplay: [Voucher] = []
    @Published var onShowProgress: Bool = false
    @Published var httpStatusCode: Int = 200
    @Published var onFetchVouchersFailed: Bool = false
    
    func fetchVouchers() {
        onShowProgress = true
        VoucherService.shared.getListVouchers(at: pageFetched + 1,
                                              completion: { vouchers, status in
                                                self.onShowProgress = false
                                                self.httpStatusCode = status
                                                self.listItemsToDisplay += vouchers
                                                self.pageFetched += 1
                                              }, onError: { error in
                                                self.onShowProgress = false
                                                self.onFetchVouchersFailed = true
                                                self.errorMessage = error.rawValue
                                              })
    }
}
