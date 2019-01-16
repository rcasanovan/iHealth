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
        
        guard let running = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            completion(false, nil)
            return
        }
        
        let healthKitTypes: Set<HKSampleType> = [running]
        
        store.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { (success, error) in
            completion(success, error)
        }
    }
    
    func getSteps(completion: @escaping HealthGetStepsCompletionBlock) {
        guard let startDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date()) else {
            completion(0, false, nil)
            return
        }
        
        let endDate = Date()
        
        print("Collecting workouts between \(startDate) and \(endDate)")
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: HKQueryOptions.strictEndDate)
        
        let query = HKSampleQuery(sampleType: HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
            for item in results! {
                print(item)
            }
            completion(0, false, nil)
        }
        
        store.execute(query)
    }
    
}
