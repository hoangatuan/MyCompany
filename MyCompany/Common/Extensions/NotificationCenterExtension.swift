//
//  NotificationCenterExtension.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/14/20.
//

import Foundation

extension Notification.Name {
    static let notificationHandlerReloadRoomAvailableView = Notification.Name("notificationHandlerReloadRoomAvailableView")
    static let notificationShowAlertBookedResponse = Notification.Name("notificationShowAlertBookedResponse")
    
    static let notificationOpenNotificationView = Notification.Name("notificationOpenNotificationView")
    static let notificationReloadViewWhenRequestUpdated = Notification.Name("notificationReloadViewWhenRequestUpdated")
    
    // Coin
    static let notificationReloadTotalCoin = Notification.Name("notificationReloadTotalCoin")
}
