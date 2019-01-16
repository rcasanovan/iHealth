//
//  GoalViewModel.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

struct GoalViewModel {
    
    let title: String
    let description: String
    let imageUrl: String
    let points: Int
    let goal: String
    let goalType: String
    
    init(title: String, description: String, imageUrl: String, points: Int, goal: String, goalType: String) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        self.points = points
        self.goal = goal
        self.goalType = goalType
    }
    
    public static func getViewModelsWith(goalsResponse: [GoalResponse]) -> [GoalViewModel] {
        return goalsResponse.map { getViewModelWith($0) }
    }
    
    private static func getViewModelWith(_ goalResponse: GoalResponse) -> GoalViewModel {
        let goalValue = getGoalValue(goalResponse.goal, type: GoalType(rawValue: goalResponse.type))
        let goalType = getGoalType(GoalType(rawValue: goalResponse.type))
        return GoalViewModel(title: goalResponse.title, description: goalResponse.description, imageUrl: "", points: goalResponse.reward.points, goal: goalValue, goalType: goalType)
    }
    
}

extension GoalViewModel {
    
    private static func getGoalValue(_ value: Int, type: GoalType?) -> String {
        guard let type = type else {
            return String(value)
        }
        
        switch type {
        case .step:
            return String(value)
        case .walking, .running:
            return String(value / 1000)
        }
    }
    
    private static func getGoalType(_ type: GoalType?) -> String {
        guard let type = type else {
            return ""
        }
        
        switch type {
        case .step:
            return "steps"
        case .walking, .running:
            return "km"
        }
    }
    
}
