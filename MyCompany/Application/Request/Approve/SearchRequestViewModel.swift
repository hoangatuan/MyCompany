//
//  SearchRequestViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/27/20.
//

import Foundation

class SearchRequestViewModel: ObservableObject {
    @Published var listRequests: [Request] = []
    @Published var onShowProgress: Bool = false
    
    var didSearchFirstTime: Bool = false
    var isNeedReload: Bool = false
    var inputText: String = "" {
        didSet {
            searchRequestByAccount()
        }
    }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(setToNeedReload),
                                               name: NSNotification.Name.notificationReloadViewWhenRequestUpdated, object: nil)
    }
    
    @objc
    func setToNeedReload() {
        isNeedReload = true
    }
    
    @objc
    func searchRequestByAccount() {
        if inputText == "" {
            listRequests = []
            return
        }
        
        didSearchFirstTime = true
        onShowProgress = true
        
        RequestService.shared.searchRequestByAccount(account: inputText) { [weak self] datas in
            self?.onShowProgress = false
            self?.listRequests = datas
        } onError: { [weak self] (error) in
            self?.onShowProgress = false
        }
    }
    
    func filterRequestsByStatus(status: Int) -> [Request] {
        if status == 0 {
            return listRequests
        } else {
            return listRequests.filter({ $0.status == status - 1 })
        }
    }
}
