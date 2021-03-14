//
//  Converter.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/7/20.
//

import Foundation

final class Converter {
    static func convertTimeFromStringToDouble(timeValue: String) -> Double {
        let hour = Double(timeValue.split(separator: ":")[0]) ?? 0
        let minute = Double(timeValue.split(separator: ":")[1] ) ?? 0
        
        return minute == 0.0 ? hour : hour + 0.5
    }
    
    static func convertTimeFromDoubleToString(timeValue: Double) -> String {
        let hourString = timeValue < 10 ? "0\(Int(timeValue))" : "\(Int(timeValue))"
        let minute = timeValue.truncatingRemainder(dividingBy: 1)
        let minuteString = minute == 0.5 ? "30" : "00"
        
        return hourString + ":" + minuteString
    }
    
    static func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    
    static func formatNumberToReadableMoney(num: String) -> String {
        let largeNumber = Int(num) ?? 0
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:largeNumber)) ?? ""
    }
}
