//
//  VoucherContentViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/1/20.
//

import UIKit

class VoucherContentViewModel: ObservableObject {
    @Published var imagesDescription: [UIImage] = []
    var imageURLs: [String] = []
    
    init(imageURLs: [String]) {
        self.imageURLs = imageURLs
        imagesDescription = Array.init(repeating: UIImage(named: "no_img")!, count: imageURLs.count)
    }
    
    func loadAllDescriptionImages() {
        for (index, value) in self.imageURLs.enumerated() {
            ImageDownloader.startDownloadImage(urlString: value, identifier: value, type: .voucherDescriptionImage, onSuccess: { [weak self] in
                let photoCachePath = LocalFileManager.shared.getPhotoCachePath(identifier: value, type: .voucherDescriptionImage)
                if let image = UIImage(contentsOfFile: photoCachePath) {
                    self?.imagesDescription[index] = image
                }
            })
        }
    }
}
