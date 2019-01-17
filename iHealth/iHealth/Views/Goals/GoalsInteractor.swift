//
//  GoalsInteractor.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

typealias getGoalsCompletionBlock = (Result<GoalsResponse?>) -> Void

class GoalsInteractor {
    
    private let requestManager: RequestManager
    private var goalsViewModel: [GoalViewModel]
    
    init() {
        goalsViewModel = []
        requestManager = RequestManager()
    }
    
}

extension GoalsInteractor {
    
    private func getGoals(simulatedJSONFile: String? = nil, completion: @escaping getGoalsCompletionBlock) {
        var goalsRequest = GoalsRequest()
        
        goalsRequest.completion = completion
        goalsRequest.simulatedResponseJSONFile = simulatedJSONFile
        requestManager.send(request: goalsRequest)
    }
    
    private func updateGoalsWith(_ goals: [GoalResponse]) {
        let goalsViewModel = GoalViewModel.getViewModelsWith(goals)
        self.goalsViewModel.append(contentsOf: goalsViewModel)
        saveGoals(goals)
    }
    
    private func saveGoals(_  goals: [GoalResponse]) {
        for eachGoal in goals {
            LocalGoalManager.shared.save(id: eachGoal.id, title: eachGoal.title, description: eachGoal.description, type: eachGoal.type, goal: eachGoal.goal, trophy: eachGoal.reward.trophy, points: eachGoal.reward.points)
        }
    }
    
}

extension GoalsInteractor: GoalsInteractorDelegate {
    
    func getGoalsList(completion: @escaping GoalsGetGoalsCompletionBlock) {
        getGoals { [weak self] (response) in
            guard let `self` = self else { return }
            
            switch response {
            case .success(let response):
                guard let response = response else {
                    completion(nil, false, nil)
                    return
                }

                self.updateGoalsWith(response.items)
                completion(self.goalsViewModel, true, nil)
            case .failure(let error):
                completion(nil, false, error)
            }
        }
    }
    
}
