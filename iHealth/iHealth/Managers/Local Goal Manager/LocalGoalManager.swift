//
//  LocalGoalManager.swift
//  iHealth
//
//  Created by Ricardo Casanova on 17/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation
import RealmSwift

class LocalGoalManager: NSObject {
    
    static let shared: LocalGoalManager = { return LocalGoalManager() }()

    public func save(id: String, title: String, description: String, type: String, goal: Int, trophy: String, points: Int) {
        if goalExists(id) { return }
        
        let goalModel = LocalGoal()
        goalModel.goalId = id
        goalModel.title = title
        goalModel.goalDescription = description
        goalModel.type = type
        goalModel.goal = goal
        goalModel.trophy = trophy
        goalModel.points = points
        
        // Get the default Realm
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(goalModel)
        }
    }
    
    public func getGoals() -> [LocalGoal] {
        let realm = try! Realm()
        
        // Query Realm for all suggestions
        // Order criteria -> id
        // Order -> ascending
        let goals = realm.objects(LocalGoal.self).sorted(byKeyPath: "goalId", ascending: true)
        return Array(goals)
    }
    
    public static func deleteAllGoals() {
        let realm = try! Realm()
        let goals = realm.objects(LocalGoal.self)
        
        try! realm.write {
            realm.delete(goals)
        }
    }
    
    public func goalExists(_ id: String) -> Bool {
        let realm = try! Realm()
        let goals = realm.objects(LocalGoal.self).filter("goalId == %@", id)
        return goals.count == 1
    }
    
}

