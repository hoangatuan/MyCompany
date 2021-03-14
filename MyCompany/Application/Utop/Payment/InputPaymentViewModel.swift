//
//  InputPaymentViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/9/20.
//

import Foundation

class InputPaymentViewModel: ObservableObject {
    enum State {
        case fail
        case invalidPayment
        case confirmPayment
    }
    
    @Published var onPaySuccess: Bool = false
    @Published var onShowProgress: Bool = false
    @Published var onShowAlert: Bool = false
    
    var errorMessage: String = ""
    var state: State = .fail
    var coinRequest: CoinRequest = CoinRequest(coinsPay: "", date: 0, type: 0, storeName: "", totalCoin: 0)
    
    func sendRequestPay(storeID: String, coins: String) {
        onShowProgress = true
        
        let type = String(CoinType.payment.rawValue)
        CoinService.shared.updateCoin(storeID: storeID, type: type, coins: coins, completion: { [weak self] coinRequest in
            self?.coinRequest = coinRequest
            self?.onShowProgress = false
            self?.onPaySuccess = true
        }, statusCode: { [weak self] statusCode in
            if statusCode == 444 {
                self?.onShowProgress = false
                self?.onShowAlert = true
                self?.state = .invalidPayment
                self?.errorMessage = "Not enough Coin to make this payment!"
            }
        }, onError: { [weak self] error in
            self?.onShowProgress = false
            self?.onShowAlert = true
            self?.state = .fail
            self?.errorMessage = error.rawValue
        })
    }
}
