//
//  UIFont.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

extension UIFont {
    
    /**
     * Get Black font
     */
    public class func blackWithSize(size : CGFloat) -> UIFont? {
        return UIFont(name: "InterUI-Black", size: size)
    }
    
    /**
     * Get Black Italic font
     */
    public class func blackItalicWithSize(size : CGFloat) -> UIFont? {
        return UIFont(name: "InterUI-BlackItalic", size: size)
    }
    
    /**
     * Get Bold font
     */
    public class func boldWithSize(size : CGFloat) -> UIFont? {
        return UIFont(name: "InterUI-Bold", size: size)
    }
    
    /**
     * Get Bold Italic font
     */
    public class func boldItalicWithSize(size : CGFloat) -> UIFont? {
        return UIFont(name: "InterUI-BoldItalic", size: size)
    }
    /**
     * Get Italic font
     */
    public class func italicWithSize(size : CGFloat) -> UIFont? {
        return UIFont(name: "InterUI-Italic", size: size)
    }
    
    /**
     * Get Medium font
     */
    public class func mediumWithSize(size : CGFloat) -> UIFont? {
        return UIFont(name: "InterUI-Medium", size: size)
    }
    
    /**
     * Get Medium Italic font
     */
    public class func mediumItalicWithSize(size : CGFloat) -> UIFont? {
        return UIFont(name: "InterUI-MediumItalic", size: size)
    }
    
    /**
     * Get Regular font
     */
    public class func regularWithSize(size : CGFloat) -> UIFont? {
        return UIFont(name: "InterUI-Regular", size: size)
    }
    
}
