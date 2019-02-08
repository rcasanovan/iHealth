//
//  ReachabilityManager.swift
//
//  Created by Ricardo Casanova on 08/01/2019.
//

import Foundation

class ReachabilityManager: NSObject {
    
    static let shared: ReachabilityManager = { return ReachabilityManager() }()
    
    public func hasConnection() -> Bool {
        let remoteHostName = "www.apple.com";
        
        let hostReachability = Reachability.init(hostName: remoteHostName)
        hostReachability?.startNotifier()
        let hostAnswer = validateAppReachibility(hostReachability)
        
        let internetReachability = Reachability.forInternetConnection()
        internetReachability?.startNotifier()
        let internetAnswer = validateAppReachibility(internetReachability)
        
        let wifiReachability = Reachability.forLocalWiFi()
        wifiReachability?.startNotifier()
        let wifiAnswer = validateAppReachibility(wifiReachability)
        
        //__ This is a fix for iOS < 10
        //__ For iOS > 10 Reachability.forLocalWiFi() returns true
        //__ so we need to to this trick
        var systemVersionLessThaniOS10 = false
        if #available(iOS 10.0, *) {
            systemVersionLessThaniOS10 = false
        } else {
            systemVersionLessThaniOS10 = true
        }
        
        if internetAnswer || hostAnswer || (systemVersionLessThaniOS10 && wifiAnswer) {
            return true
        }
        
        return false
    }
    
}

extension ReachabilityManager {
    
    private func validateAppReachibility(_ reachability: Reachability?) -> Bool {
        guard let reachability = reachability else {
            return false
        }
        
        let networkStatus = reachability.currentReachabilityStatus()
        var hasReachability: Bool = false
        
        switch networkStatus {
        case .NotReachable:
            hasReachability = false
        case .ReachableViaWiFi:
            hasReachability = true
        case .ReachableViaWWAN:
            hasReachability = true
        }
        
        return hasReachability
    }
    
}
