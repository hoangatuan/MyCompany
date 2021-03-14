//
//  CoreService.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/5/20.
//

import Foundation
import MessageUI

class CoreService {
    static func callNumber(phoneNumber: String) {
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
}
