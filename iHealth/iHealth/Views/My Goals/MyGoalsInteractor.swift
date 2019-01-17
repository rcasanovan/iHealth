//
//  MyGoalsInteractor.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

class MyGoalsInteractor {
    
    private var myGoalsViewModel: [MyGoalViewModel]
    
    init() {
        myGoalsViewModel = []
    }
    
}

extension MyGoalsInteractor: MyGoalsInteractorDelegate {
    
    func requestHealthAuthorizationIfNeeded(completion: @escaping HealthAuthCompletionBlock) {
        HealthManager.shared.requestAuthorization { (success, error) in
            completion(success, error)
        }
    }
    
    func getMyGoals() -> [MyGoalViewModel] {
        let myGoals = LocalGoalManager.shared.getAll()
        return MyGoalViewModel.getViewModelsWith(myGoals)
    }
    
    func getUserSteps() -> Int {
        return 200
    }
    
    func getUserDistance() -> Double {
        return 0.50
    }
    
}
