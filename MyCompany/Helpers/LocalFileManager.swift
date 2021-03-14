//
//  CacheService.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/29/20.
//

import UIKit

enum DataTypeCache: String {
    case newsImage = "NewsImage"
    case newContentImage = "NewContentImage"
    case avatarImage = "AvatarImage"
    case voucherDescriptionImage = "VoucherDescriptionImage"
    case voucherImage = "VoucherImage"
    case busInfoImage = "BusInfoImage"
}

final class LocalFileManager {
    enum FolderInApp: String {
        case photoCache = "PhotoCache"
    }
    
    let JPGImage: String = "jpg"
    static let shared: LocalFileManager = LocalFileManager()
    
    private func folderCachePhotoAndCreateIfNeed(_ dataType: DataTypeCache) -> String {
        let folderPath = getPathFolderInCache(typeFolder: .photoCache).appendingPathComponent(dataType.rawValue)
        if !FileManager.default.fileExists(atPath: folderPath.path) {
            do {
                try FileManager.default.createDirectory(at: folderPath, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
        return folderPath.path
    }
    
    private func getPathFolderInCache(typeFolder: FolderInApp) -> URL {
        let cachePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let folderCachePath = cachePath.appendingPathComponent(typeFolder.rawValue)
        return folderCachePath
    }
    
    func saveCacheFile(_ file: UIImage, cacheThumbPath: String) {
        let data = file.jpegData(compressionQuality: 1.0)
        let thumbnail = createThumbnailImage(data: data!)
        let thumbnailData = thumbnail.jpegData(compressionQuality: 1.0)
        
        writeFileToLocal(path: URL(fileURLWithPath: cacheThumbPath), data: thumbnailData!)
    }
    
    private func writeFileToLocal(path: URL, data: Data) {
        do {
            try data.write(to: path)
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    func removeFile(path: String) -> Bool {
        do {
            let url = URL(fileURLWithPath: path)
            try FileManager.default.removeItem(at: url)
            return true
        } catch let error {
            debugPrint(error.localizedDescription)
            return false
        }
    }
    
    func getPhotoCachePath(identifier: String, type: DataTypeCache) -> String {
        let cachePath = folderCachePhotoAndCreateIfNeed(type)
        let photoCachePath = cachePath + "/\(identifier + "_thumb").\(JPGImage)"
        return photoCachePath
    }
    
    func checkFileExist(path: String) -> Bool {
        if FileManager.default.fileExists(atPath: path) {
            return true
        }
        return false
    }
    
    func clearPhotoCache() {
        _ = removeFile(path: getPathFolderInCache(typeFolder: .photoCache).path)
    }
    
    private func createThumbnailImage(data: Data) -> UIImage {
        let options = [
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: Constants.ImageThumbnailSize] as CFDictionary
        
        let source = CGImageSourceCreateWithData(data as CFData, nil)!
        let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options)!
        let thumbnail = UIImage(cgImage: imageReference)
        
        return thumbnail
    }
}
