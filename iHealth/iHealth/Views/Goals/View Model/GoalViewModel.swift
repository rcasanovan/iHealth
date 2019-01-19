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
    
    public static func getViewModelsWith(_ goalsResponse: [GoalResponse]) -> [GoalViewModel] {
        return goalsResponse.map { getViewModelWith($0) }
    }
    
    public static func getLocalViewModelsWith(_ goals: [LocalGoal]) -> [GoalViewModel] {
        return goals.map { getLocalViewModelWith($0) }
    }
    
    private static func getViewModelWith(_ goalResponse: GoalResponse) -> GoalViewModel {
        let goalValue = getGoalValue(goalResponse.goal, type: GoalType(rawValue: goalResponse.type))
        let goalType = getGoalType(GoalType(rawValue: goalResponse.type))
        let imageUrl = getImageUrl(GoalType(rawValue: goalResponse.type), trophy: goalResponse.reward.trophy)
        return GoalViewModel(title: goalResponse.title, description: goalResponse.description, imageUrl: imageUrl, points: goalResponse.reward.points, goal: goalValue, goalType: goalType)
    }
    
    private static func getLocalViewModelWith(_ goal: LocalGoal) -> GoalViewModel {
        let type = GoalType(rawValue: goal.type)
        let goalValue = getGoalValue(goal.goal, type: type)
        let goalType = getGoalType(type)
        let imageUrl = getImageUrl(type, trophy: goal.trophy)
        return GoalViewModel(title: goal.title, description: goal.goalDescription, imageUrl: imageUrl, points: goal.points, goal: goalValue, goalType: goalType)
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
            return NSLocalizedString("steps.title", comment: "")
        case .walking, .running:
            return NSLocalizedString("km.title", comment: "")
        }
    }
    
    private static func getImageUrl(_ type: GoalType?, trophy: String) -> String {
        guard let type = type else {
            return ""
        }
        
        switch type {
        case .step:
            return "\(trophy)_s"
        case .walking:
            return "\(trophy)_w"
        case .running:
            return "\(trophy)_r"
        }
    }
    
}
