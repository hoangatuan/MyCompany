//
//  VoucherCellViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/1/20.
//

import UIKit

final class VoucherCellViewModel: ObservableObject {
    @Published var onFetchContentSuccess: Bool = false
    @Published var onFetchContentFailed: Bool = false
    @Published var voucherImage: UIImage! = UIImage(named: "no_img")
    
    var contentFetched: VoucherContent = VoucherContent(imageDescriptionURL: [], voucherID: "", contents: [])
    var errorMessage: String = ""
    
    func fetchVoucherContent(of voucherID: String) {
        VoucherService.shared.getVoucherContent(of: voucherID,
                                                completion: { [weak self] content in
                                                    self?.contentFetched = content
                                                    self?.onFetchContentSuccess = true
                                                }, onError: { [weak self] error in
                                                    self?.onFetchContentFailed = true
                                                    self?.errorMessage = error.rawValue
                                                })
    }
    
    func loadNewsImage(urlString: String, voucherID: String) {
        ImageDownloader.startDownloadImage(urlString: urlString, identifier: voucherID, type: .voucherImage, onSuccess: {
            let photoCachePath = LocalFileManager.shared.getPhotoCachePath(identifier: voucherID, type: .voucherImage)
            if let image = UIImage(contentsOfFile: photoCachePath) {
                self.voucherImage = image
            }
        })
    }
}
