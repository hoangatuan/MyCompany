//
//  NewCellViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/18/20.
//

import UIKit

final class NewCellViewModel: ObservableObject {
    @Published var newImage: UIImage! = UIImage(named: "no_img")
    @Published var onFetchContentSuccess: Bool = false
    @Published var onFetchContentFailed: Bool = false
    @Published var onLikeFailed: Bool = false
    @Published var onDislikeFailed: Bool = false
    
    var new: New = New(newID: "", title: "", imageURL: "", createDate: 0, type: 0, likes: [], dislikes: [], comments: 0)
    var contentFetched: NewContent = NewContent(newID: "", contents: [], comments: [])
    var errorMessage: String = ""
    
    func loadNewsImage(urlString: String, newID: String) {
        ImageDownloader.startDownloadImage(urlString: urlString, identifier: newID, type: .newsImage, onSuccess: {
            let photoCachePath = LocalFileManager.shared.getPhotoCachePath(identifier: newID, type: .newsImage)
            if let image = UIImage(contentsOfFile: photoCachePath) {
                self.newImage = image
            }
        })
    }
    
    func fetchNewContent(of newID: String) {
        ContentsService.shared.getNewContent(newID: newID,
                                             completion: { [weak self] content in
                                                self?.contentFetched = content
                                                self?.onFetchContentSuccess = true
                                             },
                                             onError: { [weak self] error in
                                                self?.onFetchContentFailed = true
                                                self?.errorMessage = error.rawValue
                                             })
    }
    
    func likeNew(of newID: String) {
        NewsService.shared.likeNew(newID: newID, onSuccess: { [weak self] new in
            self?.new = new
            self?.objectWillChange.send()
        }, onError: { [weak self] error in
            self?.onLikeFailed = true
            self?.errorMessage = error.rawValue
        })
    }
    
    func dislikeNew(of newID: String) {
        NewsService.shared.dislikeNew(newID: newID, onSuccess: { [weak self] new in
            self?.new = new
            self?.objectWillChange.send()
        }, onError: { [weak self] error in
            self?.onDislikeFailed = true
            self?.errorMessage = error.rawValue
        })
    }
    
    func didReaction(reactionsArray: [String]) -> Bool {
        return reactionsArray.contains(UserDataDefaults.shared.employeeID)
    }
}
