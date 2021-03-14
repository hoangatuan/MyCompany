//
//  NotificationHandler.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/12/20.
//

import Foundation

class NotificationHandler: NSObject {
    static let shared: NotificationHandler = NotificationHandler()
}

extension NotificationHandler {
    func configureRemoteNotification(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (_, _) in
                // Do nothing
            }
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
    }
}

extension NotificationHandler: UNUserNotificationCenterDelegate {
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       willPresent notification: UNNotification,
                                       withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       didReceive response: UNNotificationResponse,
                                       withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle event when tap notification
        let actionIdentifier = response.actionIdentifier
        switch actionIdentifier {
            case UNNotificationDismissActionIdentifier: // Notification was dismissed by user
                completionHandler()
            case UNNotificationDefaultActionIdentifier: // App was opened from notification
                NotificationCenter.default.post(name: NSNotification.Name.notificationOpenNotificationView, object: nil, userInfo: nil)
                completionHandler()
            default:
                completionHandler()
        }
    }
}
