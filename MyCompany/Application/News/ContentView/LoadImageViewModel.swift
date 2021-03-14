//
//  LoadImageViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/6/20.
//

import Foundation

final class LoadImageViewModel: ObservableObject {
    @Published var defaultImage: UIImage! = UIImage(named: "no_img")
    let type: DataTypeCache
    
    init(cacheType: DataTypeCache) {
        self.type = cacheType
    }
    
    func loadImage(urlString: String, identifier: String) {
        ImageDownloader.startDownloadImage(urlString: urlString, identifier: identifier, type: type, onSuccess: {
            let photoCachePath = LocalFileManager.shared.getPhotoCachePath(identifier: identifier, type: self.type)
            if let image = UIImage(contentsOfFile: photoCachePath) {
                self.defaultImage = image
            }
        })
    }
}
