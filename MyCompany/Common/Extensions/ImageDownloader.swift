//
//  ImageDownloader.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/15/20.
//

import UIKit

class ImageDownloader {
    static func startDownloadImage(urlString: String, identifier: String, type: DataTypeCache, onSuccess: @escaping () -> Void) {
        let photoCachePath = LocalFileManager.shared.getPhotoCachePath(identifier: identifier, type: type)
        if LocalFileManager.shared.checkFileExist(path: photoCachePath) {
            onSuccess()
            return
        }
        
        guard let url = URL(string: getDownloadURL(by: type, urlString: urlString)) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            if let image = UIImage(data: data) {
                LocalFileManager.shared.saveCacheFile(image, cacheThumbPath: photoCachePath)
                DispatchQueue.main.async {
                    onSuccess()
                }
            }
        }.resume()
    }
    
    static func getDownloadURL(by type: DataTypeCache, urlString: String) -> String {
        switch type {
        case .avatarImage:
            return RouterManager.GetEmployeeAvatarURL + urlString
        case .newsImage:
            return RouterManager.GetNewsImage + urlString
        case .newContentImage:
            return RouterManager.GetContentImage + urlString
        case .voucherImage:
            return RouterManager.GetVoucherImage + urlString
        case .voucherDescriptionImage:
            return RouterManager.GetVoucherDescriptionImage + urlString
        case .busInfoImage:
            return RouterManager.GetBusImage + urlString
        }
    }
}
