//
//  CommentCellViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/29/20.
//

import UIKit

final class CommentCellViewModel: ObservableObject {
    @Published var avatarImage: UIImage = UIImage(named: "no_img")!
    
    func loadAvatarImage(userID: String, urlString: String) {
        ImageDownloader.startDownloadImage(urlString: urlString, identifier: userID, type: .avatarImage, onSuccess: {
            let photoCachePath = LocalFileManager.shared.getPhotoCachePath(identifier: userID, type: .avatarImage)
            if let image = UIImage(contentsOfFile: photoCachePath) {
                self.avatarImage = image
            }
        })
    }
}
