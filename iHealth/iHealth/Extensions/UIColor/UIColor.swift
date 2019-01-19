//
//  UIColor.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

extension UIColor {
    /**
     * Get the UIColor value from hex
     *
     * - parameters:
     *     - hex: the hex value to transform
     */
    public class func colorWithHex(hex:String) -> UIColor {
        return UIColor.colorWithHex(hex: hex, alpha: 1.0)
    }
    
    /**
     * Get the UIColor value from hex and alpha
     *
     * - parameters:
     *     - hex: the hex value to transform
     *     - alpha: the alpha value for the color
     */
    public class func colorWithHex(hex:String, alpha:CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
}

extension UIColor {
    
    public static func white() -> UIColor {
        return UIColor.white
    }
    
    public static func black() -> UIColor {
        return UIColor.black
    }
    
    public static func gray() -> UIColor {
        return UIColor.colorWithHex(hex: "#313336")
    }
    
    public static func blue() -> UIColor {
        return UIColor.colorWithHex(hex: "#00c7dd")
    }
    
    public static func green() -> UIColor {
        return UIColor.colorWithHex(hex: "#59e707")
    }
    
    public static func red() -> UIColor {
        return UIColor.colorWithHex(hex: "#e71135")
    }
    
}
