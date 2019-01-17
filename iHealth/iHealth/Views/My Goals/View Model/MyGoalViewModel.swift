//
//  MyGoalViewModel.swift
//  iHealth
//
//  Created by Ricardo Casanova on 17/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

struct MyGoalViewModel {
    
    let title: String
    let points: Int
    let goal: String
    let goalType: String
    
    init(title: String, points: Int, goal: String, goalType: String) {
        self.title = title
        self.points = points
        self.goal = goal
        self.goalType = goalType
    }
    
    public static func getViewModelsWith(_ goals: [LocalGoal]) -> [MyGoalViewModel] {
        return goals.map { getViewModelWith($0) }
    }
    
    private static func getViewModelWith(_ goal: LocalGoal) -> MyGoalViewModel {
        let goalValue = getGoalValue(goal.goal, type: GoalType(rawValue: goal.type))
        let goalType = getGoalType(GoalType(rawValue: goal.type))
        return MyGoalViewModel(title: goal.title, points: goal.points, goal: goalValue, goalType: goalType)
    }
    
}

extension MyGoalViewModel {
    
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

