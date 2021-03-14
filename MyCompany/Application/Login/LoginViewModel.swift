//
//  LoginViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/8/20.
//

import Foundation
import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoginFail = false
    
    var errorMessage: String = ""
    
    func isInvalidInput() -> Bool {
        if username.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty {
            return true
        }
        
        return false
    }
    
    func login() {
        AuthenticationService.shared.login(username: username, password: password) { [weak self] status in
            switch status {
            case .success:
                self?.updateRootView()
            default:
                self?.isLoginFail = true
                self?.errorMessage = status.rawValue
            }
        }
    }
    
    private func updateRootView() {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene

        if let windowScenedelegate = scene?.delegate as? SceneDelegate {
           let window = UIWindow(windowScene: scene!)
            
            if UserDataDefaults.shared.isAdministrator {
                window.rootViewController = UIHostingController(rootView: AdminView())
            } else {
                window.rootViewController = UIHostingController(rootView: MainTabbarView())
            }      
           windowScenedelegate.window = window
           window.makeKeyAndVisible()
        } else {
            debugPrint("LoginView - Can not found scene delegate to Push to Home view")
        }
    }
}
