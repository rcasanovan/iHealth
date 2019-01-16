//
//  NetworkHeaders.swift
//
//  Created by Ricardo Casanova on 03/09/2018.
//  Copyright © 2018. All rights reserved.
//

import Foundation

final class NetworkHeaders {
    
    private enum Keys {
        static let authorizationKey = "Authorization"
    }
    
    static func create() -> [AnyHashable: Any] {
        
        let headers: [AnyHashable: Any] = [:]
        return headers
        
    }
}
