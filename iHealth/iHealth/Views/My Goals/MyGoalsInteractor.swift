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
    private var userSteps: Int
    private var userDistance: Double
    private var completion: MyGoalsGetGoalsCompletionBlock?
    
    init() {
        myGoalsViewModel = []
        userSteps = 0
        userDistance = 0.0
    }
    
}

extension MyGoalsInteractor {
    
    private func getUserSteps() {
        HealthManager.shared.getValueForType(.steps) { [weak self] (steps, success) in
            guard let `self` = self else { return }
            
            self.userSteps = Int(steps)
            self.getUserDistance()
        }
    }
    
    private func getUserDistance() {
        HealthManager.shared.getValueForType(.distance) { [weak self] (distance, success) in
            guard let `self` = self else { return }
            
            self.userDistance = distance / 1000
            self.getUserGoals()
        }
    }
    
    private func getUserGoals() {
        let myGoals = LocalGoalManager.shared.getAll()
        myGoalsViewModel = MyGoalViewModel.getViewModelsWith(myGoals, userSteps: userSteps, userDistance: userDistance)
        completion?(myGoalsViewModel)
    }
    
}

extension MyGoalsInteractor: MyGoalsInteractorDelegate {
    
    func requestHealthAuthorizationIfNeeded(completion: @escaping HealthAuthCompletionBlock) {
        HealthManager.shared.requestAuthorization { (success, error) in
            completion(success, error)
        }
    }
    
    func getMyGoals(completion: @escaping MyGoalsGetGoalsCompletionBlock) {
        self.completion = completion
        getUserSteps()
    }
    
    func clear() {
        myGoalsViewModel = []
        userSteps = 0
        userDistance = 0.0
    }
    
}
