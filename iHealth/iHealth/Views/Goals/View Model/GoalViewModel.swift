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
    
    init(title: String, description: String, imageUrl: String, points: Int) {
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        self.points = points
    }
    
    public static func getViewModelsWith(goalsResponse: [GoalResponse]) -> [GoalViewModel] {
        return goalsResponse.map { getViewModelWith($0) }
    }
    
    private static func getViewModelWith(_ goalResponse: GoalResponse) -> GoalViewModel {
        return GoalViewModel(title: goalResponse.title, description: goalResponse.description, imageUrl: "", points: goalResponse.reward.points)
    }
    
}
