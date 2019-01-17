//
//  UIEdgeInsets.swift
//  iHealth
//
//  Created by Ricardo Casanova on 17/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

extension UIEdgeInsets {
    
    static var safeAreaInsets: UIEdgeInsets = {
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return UIEdgeInsets.zero }
        let insets: UIEdgeInsets
        if #available(iOS 11.0, *) {
            insets = window.safeAreaInsets
        } else {
            insets = UIEdgeInsets.zero
        }
        return insets
    }()
    
}
