//
//  ExchangeCoinViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/8/20.
//

import Foundation

class ExchangeCoinViewModel: ObservableObject {
    enum State {
        case success
        case fail
    }
    
    @Published var onShowProgress: Bool = false
    @Published var onShowAlert: Bool = false
    
    var errorMessage: String = ""
    var state: State = .fail
    
    func startExchangeCoin(coins: String) {
        onShowProgress = true
        let type = String(CoinType.exchange.rawValue)
        CoinService.shared.updateCoin(storeID: "", type: type,
                                      coins: coins, completion: { [weak self] coinRequest in
                                        self?.onShowProgress = false
                                        self?.onShowAlert = true
                                        self?.state = .success
                                      }, statusCode: { _ in },
                                      onError: { [weak self] error in
                                        self?.onShowProgress = false
                                        self?.onShowAlert = true
                                        self?.state = .fail
                                        self?.errorMessage = error.rawValue
                                      })
    }
}
