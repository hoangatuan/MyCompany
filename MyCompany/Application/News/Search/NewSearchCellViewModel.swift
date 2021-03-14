//
//  NewSearchCellViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/18/20.
//

import UIKit

class NewSearchCellViewModel: ObservableObject {
    @Published var newImage: UIImage! = UIImage(named: "no_img")
    @Published var onFetchContentSuccess: Bool = false
    @Published var onFetchContentFailed: Bool = false
    
    var errorMessage: String = ""
    
    var newInfo: New
    var contentFetched: NewContent = NewContent(newID: "", contents: [], comments: [])
    
    init(new: New) {
        self.newInfo = new
    }
    
    func loadNewsImage(urlString: String, newID: String) {
        ImageDownloader.startDownloadImage(urlString: urlString, identifier: newID, type: .newsImage, onSuccess: {
            let photoCachePath = LocalFileManager.shared.getPhotoCachePath(identifier: newID, type: .newsImage)
            if let image = UIImage(contentsOfFile: photoCachePath) {
                self.newImage = image
            }
        })
    }
    
    func fetchNewContent() {
        ContentsService.shared.getNewContent(newID: newInfo.newID,
                                             completion: { [weak self] content in
                                                self?.contentFetched = content
                                                self?.onFetchContentSuccess = true
                                             },
                                             onError: { [weak self] error in
                                                self?.onFetchContentFailed = true
                                                self?.errorMessage = error.rawValue
                                             })
    }
}
