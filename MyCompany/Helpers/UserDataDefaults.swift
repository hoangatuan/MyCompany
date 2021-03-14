//
//  UserDataDefaults.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/11/20.
//

import Foundation

final class UserDataDefaults {
    static let shared = UserDataDefaults()
    
    // - MARK: Key
    private let employeeEmailKey: String = "employeeEmailKey"
    private let employeeIDKey: String = "employeeIDKey"
    private let employeeAvatarUrlKey: String = "employeeAvatarUrlKey"
    private let employeeAccountKey: String = "employeeAccountKey"
    private let employeeFullnameKey: String = "employeeFullnameKey"
    
    private let isAdministratorKey: String = "isAdministratorKey"
    
    private let isOpenFromNotificationKey: String = "isOpenFromNotificationKey"
    
    // - MARK: Get / Set
    var employeeEmail: String {
        get {
            return UserDefaults.standard.string(forKey: employeeEmailKey) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: employeeEmailKey)
        }
    }
    
    var employeeID: String {
        get {
            return UserDefaults.standard.string(forKey: employeeIDKey) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: employeeIDKey)
        }
    }
    
    var employeeAvatarImageUrl: String {
        get {
            return UserDefaults.standard.string(forKey: employeeAvatarUrlKey) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: employeeAvatarUrlKey)
        }
    }
    
    var employeeAccount: String {
        get {
            return UserDefaults.standard.string(forKey: employeeAccountKey) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: employeeAccountKey)
        }
    }
    
    var employeeName: String {
        get {
            return UserDefaults.standard.string(forKey: employeeFullnameKey) ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: employeeFullnameKey)
        }
    }
    
    var isAdministrator: Bool {
        get {
            return UserDefaults.standard.bool(forKey: isAdministratorKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: isAdministratorKey)
        }
    }
    
    var isOpenFromNotification: Bool {
        get {
            return UserDefaults.standard.bool(forKey: isOpenFromNotificationKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: isOpenFromNotificationKey)
        }
    }
}
