//
//  ScanViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/12/20.
//

import Foundation

class ScanViewModel: ObservableObject {
    @Published var onShowPaymentView: Bool = false
    
    var store: Store = Store(name: "")
    
    func getInfo(storeID: String) {
        CoinService.shared.getStore(storeID: storeID) { (store) in
            self.onShowPaymentView = true
            self.store = store
        } onError: { (error) in
            print(error)
        }
    }
}
