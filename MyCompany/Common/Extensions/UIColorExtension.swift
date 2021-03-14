//
//  UIColorExtension.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/21/20.
//

import UIKit

extension UIColor {
    static let ColorFF88A7 = UIColor(hexString: "FF88A7") ?? UIColor()  // Pink color
    static let Color808080 = UIColor(hexString: "808080") ?? UIColor()
    static let ColorE9E9E9 = UIColor(hexString: "E9E9E9") ?? UIColor()
    //Admin
    static let Color3B13B8 = UIColor(hexString: "3B13B8") ?? UIColor()
    static let ColorFF596E = UIColor(hexString: "FF596E") ?? UIColor()
    static let Color007AFF = UIColor(hexString: "007AFF") ?? UIColor()
    static let Color02CEFD = UIColor(hexString: "02CEFD") ?? UIColor()
}

extension UIColor {
    static let hexOfRed: UInt32 = 0xFF0000
    static let hexOfGreen: UInt32 = 0x00FF00
    static let hexOfBlue: UInt32 = 0x0000FF
    
    convenience init?(hexString: String) {
        let scanner = Scanner(string: hexString)
        var hexNumber: UInt32 = 0
        if hexString.count != 6 || !scanner.scanHexInt32(&hexNumber) {
            return nil
            
        }
        
        let red = CGFloat((hexNumber & UIColor.hexOfRed) >> 16) / 255.0
        let green = CGFloat((hexNumber & UIColor.hexOfGreen) >> 8) / 255.0
        let blue = CGFloat(hexNumber & UIColor.hexOfBlue) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    convenience init?(hexString: String, alpha: Double) {
        let scanner = Scanner(string: hexString)
        var hexNumber: UInt32 = 0
        if hexString.count != 6 || !scanner.scanHexInt32(&hexNumber) {
            return nil
            
        }
        
        let red = CGFloat((hexNumber & UIColor.hexOfRed) >> 16) / 255.0
        let green = CGFloat((hexNumber & UIColor.hexOfGreen) >> 8) / 255.0
        let blue = CGFloat(hexNumber & UIColor.hexOfBlue) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: CGFloat(alpha))
    }
}
