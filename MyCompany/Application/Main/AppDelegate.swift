//
//  AppDelegate.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/8/20.
//

import UIKit
import PusherSwift
import UserNotifications
import PushNotifications
import Braintree

@main
class AppDelegate: UIResponder, UIApplicationDelegate, PusherDelegate {
    var pusher: Pusher!
    let pushNotifications = PushNotifications.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupPusher()
        registerForPushNotifications()
        
        BTAppSwitch.setReturnURLScheme("com.hoangatuan.MyCompanyPushNoti.payments")
        
        registerForApproveNotification()
        NotificationHandler.shared.configureRemoteNotification(application)
        
        return true
    }
    
    private func setupPusher() {
        let options = PusherClientOptions(
            host: .cluster("ap1")
        )
        
        pusher = Pusher(
            key: "3467e37f44f40fec806f",
            options: options
        )
        
        pusher.delegate = self
        
        // subscribe to channel
        let coinChannel = pusher.subscribe("coin-channel")
        // bind a callback to handle an event
        let _ = coinChannel.bind(eventName: "update-event", eventCallback: { (event: PusherEvent) in
            if let data = event.property(withKey: "data") as? String {
                let dic = Converter.convertStringToDictionary(text: data)
                if let message = dic?["message"] as? [String: Int] {
                    NotificationCenter.default.post(name: NSNotification.Name.notificationReloadTotalCoin,
                                                    object: nil, userInfo: message)
                }
            }
        })
        
        pusher.connect()
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, _ in
            print("Permission granted: \(granted)")
            guard granted else {
                return
            }
            
            self?.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
      UNUserNotificationCenter.current().getNotificationSettings { settings in
        guard settings.authorizationStatus == .authorized else {
            return
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
      }
    }
    
    private func registerForApproveNotification() {
        self.pushNotifications.start(instanceId: "39428eca-e8b2-413e-b665-682538c475e2")
        registerForApproval()
        self.pushNotifications.registerForRemoteNotifications()
    }
    
    func registerForApproval() {
        if UserDataDefaults.shared.employeeID != "" {
            debugPrint("Tuanha24: register for approval: \(UserDataDefaults.shared.employeeID)")
            try? self.pushNotifications.addDeviceInterest(interest: "approval-\(UserDataDefaults.shared.employeeID)")
        }
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        LocalFileManager.shared.clearPhotoCache()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        pushNotifications.registerDeviceToken(deviceToken)
        // Push device token to server -> Server save device token -> Use device token as an address to deliver notification to device
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("failed to register: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        NotificationCenter.default.post(name: NSNotification.Name.notificationReloadViewWhenRequestUpdated, object: nil, userInfo: nil)
        completionHandler(.noData)
    }
}
