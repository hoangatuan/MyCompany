//
//  ApproveRequestViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/26/20.
//

import Foundation

class ApproveRequestViewModel: ObservableObject {
    enum ResponseStatus: String {
        case emptyInput = "Please input Approve Note"
        case success = "Edit request success"
    }
    
    @Published var avatarImage: UIImage! = UIImage(named: "no_img")
    @Published var onShowAlert: Bool = false
    
    var request: Request
    var status: ResponseStatus = .emptyInput
    
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
    
    func approve(approveStatus: StatusRequest, approveNote: String) {
        if approveStatus == .deny && approveNote.trimmingCharacters(in: .whitespaces).isEmpty {
            onShowAlert = true
            status = .emptyInput
            return
        }
        
        RequestService.shared.approveRequest(requestID: request.requestID,
                                             approveStatus: String(approveStatus.rawValue), approveNote: approveNote, completion: { [weak self] request in
                                                self?.status = .success
                                                self?.onShowAlert = true
                                                self?.request = request
        })
    }
}
