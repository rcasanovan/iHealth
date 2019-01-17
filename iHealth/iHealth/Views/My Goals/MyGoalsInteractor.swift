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

extension MyGoalsInteractor {
    
    private func getUserSteps() -> Int {
        return 200
    }
    
    private func getUserDistance() -> Double {
        return 0.50
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
        let userSteps = getUserSteps()
        let userDistance = getUserDistance()
        return MyGoalViewModel.getViewModelsWith(myGoals, userSteps: userSteps, userDistance: userDistance)
    }
    
}
