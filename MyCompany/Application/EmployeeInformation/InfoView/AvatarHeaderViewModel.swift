//
//  AvatarHeaderViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/18/20.
//

import UIKit

final class AvatarHeaderViewModel: ObservableObject {
    @Published var avatarImage: UIImage! = UIImage(named: "no_img")
    @Published var onUpdateAvatarImageFailed: Bool = false
    @Published var onShowProgress: Bool = false
    
    private let avatarImageSize: CGFloat = 200.0
    
    func updateAvatarImage(inputImage: UIImage?) {
        onShowProgress = true
        guard let unwrapImage = inputImage else {
            onShowProgress = false
            onUpdateAvatarImageFailed = true
            return
        }
        
        guard let resizedImage = unwrapImage.resizeImage(targetSize: CGSize(width: avatarImageSize, height: avatarImageSize)) else {
            onShowProgress = false
            onUpdateAvatarImageFailed = true
            return
        }
        
        EmployeeService.shared.updateAvatarImage(with: resizedImage, onSuccess: { [weak self] success in
            self?.onShowProgress = false
            
            if success {
                self?.avatarImage = resizedImage
            } else {
                self?.onUpdateAvatarImageFailed = true
            }
        })
    }
    
    func requestGetAvatarImage(urlString: String) {
        guard let url = URL(string: RouterManager.GetEmployeeAvatarURL + urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            guard let data = data else {
                return
            }
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.avatarImage = image
                }
            }
            
        }.resume()
    }
}
