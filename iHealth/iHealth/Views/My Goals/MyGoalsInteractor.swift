//
//  MyGoalsInteractor.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

class MyGoalsInteractor {
    
    init() {
    }
    
}

extension MyGoalsInteractor: MyGoalsInteractorDelegate {
    
    func requestHealthAuthorizationIfNeeded(completion: @escaping HealthAuthCompletionBlock) {
        HealthManager.shared.requestAuthorization { (success, error) in
            completion(success, error)
        }
    }
    
}
