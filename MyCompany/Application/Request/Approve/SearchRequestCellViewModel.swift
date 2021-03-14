//
//  SearchRequestCellViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/27/20.
//

import Foundation

class SearchRequestCellViewModel: ObservableObject {
    @Published var avatarImage: UIImage! = UIImage(named: "no_img")
    var request: Request
    
    init(request: Request) {
        self.request = request
    }
    
    func loadAvasImage() {
        ImageDownloader.startDownloadImage(urlString: request.imageURL, identifier: request.employeeID, type: .avatarImage, onSuccess: {
            let photoCachePath = LocalFileManager.shared.getPhotoCachePath(identifier: self.request.employeeID, type: .avatarImage)
            if let image = UIImage(contentsOfFile: photoCachePath) {
                self.avatarImage = image
            }
        })
    }
}
