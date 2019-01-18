//
//  Device.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

struct Device {
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    
    public static func takeScreenshot() -> UIImage? {
        var screenshotImage :UIImage?
        guard let layer = UIApplication.shared.keyWindow?.layer else { return nil }
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshotImage
    }
    
}
