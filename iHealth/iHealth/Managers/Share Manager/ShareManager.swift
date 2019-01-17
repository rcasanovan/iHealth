//
//  ShareManager.swift
//  iHealth
//
//  Created by Ricardo Casanova on 18/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class ShareManager {
    
    static let shared: ShareManager = { return ShareManager() }()
    
    public func share(_ items: [Any], from: UIViewController) {
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        from.present(ac, animated: true)
    }
    
}
