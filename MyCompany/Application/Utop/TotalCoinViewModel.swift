//
//  TotalCoinViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/9/20.
//

import Foundation

class TotalCoinViewModel: ObservableObject {
    @Published var totalCoin: Int
    
    init(totalCoin: Int) {
        self.totalCoin = totalCoin
        self.requestTotalCoin()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadTotalCoin), name: NSNotification.Name.notificationReloadTotalCoin,
                                               object: nil)
    }
    
    @objc
    func reloadTotalCoin(notification: NSNotification) {
        guard let userInfo = notification.userInfo as? [String: Int],
              let totalCoin = userInfo["totalCoin"] else {
            return
        }
        
        self.totalCoin = totalCoin
    }
    
    private func requestTotalCoin() {
        if totalCoin != 0 {
            return
        }
        
        CoinService.shared.getTotalCoin { (coin) in
            self.totalCoin = coin
        }
    }
}
