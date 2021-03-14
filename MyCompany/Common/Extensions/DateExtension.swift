//
//  DateExtension.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/24/20.
//

import Foundation

enum DateFormatType: String {
    case iso = "dd-MMM-yyyy"
    case comment = "dd MMM yyyy HH:mm:ss"
    case HMS = "HH:mm:ss"
    case hour = "HH"
}

extension Date {
    func convertToFormat(format: DateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = .current
        
        return dateFormatter.string(from: self)
    }
    
    func getCurrentHour() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "HH"
        dateFormatter.timeZone = .current
        
        let hourString = dateFormatter.string(from: self)
        return Int(hourString) ?? 0
    }
}
