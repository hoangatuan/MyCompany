//
//  SplashView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/24/20.
//

import UIKit
import SwiftUI

final class SplashView: UIViewController {

    @IBOutlet private weak var gstLogo1Image: UIImageView!
    @IBOutlet private weak var gstLogo2Image: UIImageView!
    @IBOutlet private weak var labelGST: UILabel!
    
    @IBOutlet private weak var logo1TrailingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var logo2LeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var labelGSTLeadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimationLogo()
    }
    
    private func startAnimationLogo() {
        UIView.animate(withDuration: 0.5, animations: {
            self.logo1TrailingConstraint.constant -= (UIScreen.main.bounds.width + self.gstLogo1Image.frame.width) / 2
            self.logo2LeadingConstraint.constant -= (UIScreen.main.bounds.width + self.gstLogo2Image.frame.width) / 2
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.startAnimationLabel()
        })
    }
    
    private func startAnimationLabel() {
        UIView.animate(withDuration: 0.5, animations: {
            self.labelGSTLeadingConstraint.constant -= (UIScreen.main.bounds.width + self.labelGST.frame.width) / 2
            
            self.view.layoutIfNeeded()
        }, completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                guard let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate else {
                    debugPrint("SplashView - Can not found scene delegate to Push to Login/Home view")
                    return
                }
                
                let currentEmployeeEmail = UserDataDefaults.shared.employeeEmail
                if currentEmployeeEmail == "" {
                    sceneDelegate.window?.rootViewController = UIHostingController(rootView: LoginView())
                } else {
                    sceneDelegate.window?.rootViewController = UIHostingController(rootView: MainTabbarView())
                }
            }
        })
    }
}

struct SplashViewRepresentation: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<SplashViewRepresentation>) -> SplashView {
        let storyboard = UIStoryboard(name: "Splash", bundle: nil)
        let splashView = storyboard.instantiateViewController(withIdentifier: "SplashView") as! SplashView
        return splashView
    }
    
    func updateUIViewController(_ uiViewController: SplashView,
                                context: UIViewControllerRepresentableContext<SplashViewRepresentation>) {
        
    }
}
