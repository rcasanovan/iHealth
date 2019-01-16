//
//  GoalResponse.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

enum GoalType: String {
    case step = "step"
    case walking = "walking_distance"
    case running = "running_distance"
}

public struct GoalsResponse: Decodable {
    
    let items: [GoalResponse]
    
}

public struct GoalResponse: Decodable {
    
    let id: String
    let title: String
    let description: String
    let type: String
    let goal: Int
    let reward: RewardResponse
    
}

public struct RewardResponse: Decodable {
    
    let trophy: String
    let points: Int
    
}
