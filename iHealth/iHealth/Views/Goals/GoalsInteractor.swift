//
//  GoalsInteractor.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

class GoalsInteractor {
    
    private let requestManager: RequestManager
    private var goalsViewModel: [GoalViewModel]
    
    init() {
        goalsViewModel = []
        requestManager = RequestManager()
    }
    
}

extension GoalsInteractor: GoalsInteractorDelegate {
    
    func getGoals(completion: @escaping GoalsGetGoalsCompletionBlock) {
    }
    
}
