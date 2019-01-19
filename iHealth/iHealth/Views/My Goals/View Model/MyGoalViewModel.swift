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
    let percentage: CGFloat
    let percentageTitle: String
    let percentageColor: UIColor
    
    init(title: String, points: Int, goal: String, goalType: String, percentage: CGFloat, percentageTitle: String, percentageColor: UIColor) {
        self.title = title
        self.points = points
        self.goal = goal
        self.goalType = goalType
        self.percentage = percentage
        self.percentageTitle = percentageTitle
        self.percentageColor = percentageColor
    }
    
    public static func getViewModelsWith(_ goals: [LocalGoal], userSteps: Int, userDistance: Double) -> [MyGoalViewModel] {
        return goals.map { getViewModelWith($0, userSteps: userSteps, userDistance: userDistance) }
    }
    
    private static func getViewModelWith(_ goal: LocalGoal, userSteps: Int, userDistance: Double) -> MyGoalViewModel {
        let type = GoalType(rawValue: goal.type)
        let goalValue = getGoalValue(userSteps: userSteps, userDistance: userDistance, value: goal.goal, type: type)
        let goalType = getGoalType(type)
        let color = getColor(type)
        let percentage = getPercentage(userSteps: userSteps, userDistance: userDistance, value: goal.goal, type: type)
        return MyGoalViewModel(title: goal.title, points: goal.points, goal: goalValue, goalType: goalType, percentage: percentage, percentageTitle: "\(Int(percentage))%", percentageColor: color)
    }
    
}

extension MyGoalViewModel {
    
    private static func getGoalValue(userSteps: Int, userDistance: Double, value: Int, type: GoalType?) -> String {
        guard let type = type else {
            return String(value)
        }
        
        switch type {
        case .step:
            return "\(userSteps) / \(value)"
        case .walking, .running:
            return "\(String(format: "%.3f", userDistance)) / \(value/1000)"
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
            return "km"
        }
    }
    
    private static func getColor(_ type: GoalType?) -> UIColor {
        guard let type = type else {
            return .clear
        }
        
        switch type {
        case .step:
            return UIColor.colorWithHex(hex: "#00c7dd")
        case .walking:
            return UIColor.colorWithHex(hex: "#59e707")
        case .running:
            return UIColor.colorWithHex(hex: "#e71135")
        }
    }
    
    private static func getPercentage(userSteps: Int, userDistance: Double, value: Int, type: GoalType?) -> CGFloat {
        guard let type = type else {
            return 0.0
        }
        
        switch type {
        case .step:
            return CGFloat((userSteps * 100)/value)
        case .walking, .running:
            return CGFloat(((userDistance*1000) * 100)/Double(value))
        }
    }
    
}

