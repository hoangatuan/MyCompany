//
//  BusInfoViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/20/20.
//

import SwiftUI

final class BusInfoViewModel: ObservableObject {
    @Published var listBusInfos: [BusInfo] = []
    @Published var onFetchBusinfosFailed: Bool = false
    @Published var onShowProgress: Bool = false
    
    func requestGetBusInfo() {
        onShowProgress = true
        
        BusService.shared.getAllBusInfo { [weak self] infos in
            guard let busInfos = infos else {
                self?.onShowProgress = false
                self?.onFetchBusinfosFailed = true
                return
            }
            
            self?.onShowProgress = false
            self?.listBusInfos = busInfos
        }
    }
}
