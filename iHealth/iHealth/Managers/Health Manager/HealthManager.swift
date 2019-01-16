//
//  HealthManager.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation
import HealthKit

typealias HealthAuthCompletionBlock = (_ success: Bool, _ error: Error?) -> Void

class HealthManager: NSObject {
    
    static let shared: HealthManager = { return HealthManager() }()
    
    public func requestAuthorization(completion: @escaping HealthAuthCompletionBlock) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, nil)
            return
        }
        
        guard   let running = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning) else {
                completion(false, nil)
                return
        }
        
        let healthKitTypes: Set<HKSampleType> = [running]
        
        HKHealthStore().requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { (success, error) in
            completion(success, error)
        }
    }

}
