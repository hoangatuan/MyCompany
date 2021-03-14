//
//  OrderHistoryCellViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/22/20.
//

import Foundation

class OrderHistoryCellViewModel: ObservableObject {
    @Published var voucherImage: UIImage = UIImage(named: "no_img")!
    
    func loadVoucherImage(urlString: String, voucherID: String) {
        ImageDownloader.startDownloadImage(urlString: urlString, identifier: voucherID, type: .voucherImage, onSuccess: {
            let photoCachePath = LocalFileManager.shared.getPhotoCachePath(identifier: voucherID, type: .voucherImage)
            if let image = UIImage(contentsOfFile: photoCachePath) {
                self.voucherImage = image
            }
        })
    }
}
