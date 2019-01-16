//
//  HealthManager.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation
import HealthKit

class HealthManager: NSObject {
    
    let store: HKHealthStore
    static let shared: HealthManager = { return HealthManager() }()
    
    private override init() {
        self.store = HKHealthStore()
        super.init()
    }

}

extension HealthManager: HealthDelegate {
    
    func requestAuthorization(completion: @escaping HealthAuthCompletionBlock) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, nil)
            return
        }
        
        guard let running = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning),
            let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            completion(false, nil)
            return
        }
        
        let healthKitTypes: Set<HKSampleType> = [running, stepsQuantityType]
        
        store.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { (success, error) in
            completion(success, error)
        }
    }
    
    func getSteps(completion: @escaping HealthGetStepsCompletionBlock) {
        guard let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            completion(0, false, nil)
            return
        }
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0, false, nil)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()), true, nil)
        }
        
        store.execute(query)
    }
    
}
