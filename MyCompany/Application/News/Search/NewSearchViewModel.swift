//
//  NewSearchViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/18/20.
//

import Foundation

class NewSearchViewModel: ObservableObject {
    @Published var newDatasToPresent: [New] = []
    let filterArrays: [String] = ["News", "Announcements"]
    
    var didSearchFirstTime: Bool = false
    
    func searchNewByTitle(title: String, type: NewType) {
        if title == "" {
            newDatasToPresent = []
            return
        }
        
        didSearchFirstTime = true
        NewsService.shared.searchViewByTitle(title: title, type: type, completion: { [weak self] datas, status in
            var sortedNews = datas
            sortedNews.sort(by: { $0.createDate > $1.createDate })
            self?.newDatasToPresent = sortedNews
        }, onError: { error in
            
        })
    }
}
