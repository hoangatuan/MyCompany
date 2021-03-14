//
//  NewViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/18/20.
//

import Foundation

final class NewViewModel: ObservableObject {
    @Published var listItemsToDisplay: [New] = []
    @Published var httpStatusCodeNew: Int = 200
    @Published var httpStatusCodeAnnouncement: Int = 200
    @Published var onFetchNewsFailed: Bool = false
    @Published var onShowProgress: Bool = true
    @Published var stateModel: RightActionStateModel = RightActionStateModel()

    var errorMessage = ""
    
    var pageNewFetched: Int = 0
    var pageAnnouncementFetched: Int = 0
    
    init() {
        fetchAllNews(type: .announcement)
        fetchAllNews(type: .new)
        NotificationCenter.default.addObserver(self, selector: #selector(handleOpenNotificationInNewView),
                                               name: NSNotification.Name.notificationOpenNotificationView, object: nil)
    }
    
    func fetchAllNews(type: NewType) {
        onShowProgress = true
        let pageToFetch = type == .new ? pageNewFetched + 1 : pageAnnouncementFetched + 1
        NewsService.shared.getListNews(at: pageToFetch, type: type) { [weak self] (news, statusCode) in
            if type == .new {
                self?.httpStatusCodeNew = statusCode
            } else {
                self?.httpStatusCodeAnnouncement = statusCode
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                var sortedNews = news
                sortedNews.sort(by: { $0.createDate > $1.createDate })
                self?.updateListItemsDisplay(items: sortedNews, type: type)
            })
        } onError: { [weak self] (error) in
            self?.onShowProgress = false
            self?.onFetchNewsFailed = true
            self?.errorMessage = error.rawValue
        }
    }
    
    private func updateListItemsDisplay(items: [New], type: NewType) {
        onShowProgress = false
        switch type {
        case .new:
            pageNewFetched += 1
            listItemsToDisplay += items
        case .announcement:
            pageAnnouncementFetched += 1
            listItemsToDisplay += items
        }
    }
    
    func getNewToDisplay(type: NewType) -> [New] {
        return listItemsToDisplay.filter({ $0.type == type.rawValue })
    }
    
    @objc
    private func handleOpenNotificationInNewView() {
        if !stateModel.onShowNotificationView {
            stateModel.onShowNotificationView = true
        }
    }
}
