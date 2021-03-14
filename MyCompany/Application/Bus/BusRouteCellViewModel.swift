//
//  BusRouteCellViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/15/20.
//

import UIKit

class BusRouteCellViewModel: ObservableObject {
    @Published var routeImage: UIImage! = UIImage(named: "no_img")
    
    func loadNewsImage(urlString: String, routeID: String) {
        ImageDownloader.startDownloadImage(urlString: urlString, identifier: routeID, type: .busInfoImage, onSuccess: {
            let photoCachePath = LocalFileManager.shared.getPhotoCachePath(identifier: routeID, type: .busInfoImage)
            if let image = UIImage(contentsOfFile: photoCachePath) {
                self.routeImage = image
            }
        })
    }
}
