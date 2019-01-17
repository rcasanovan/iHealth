//
//  LocalGoalsTests.swift
//  iHealthTests
//
//  Created by Ricardo Casanova on 17/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import XCTest
@testable import iHealth

class LocalGoalsTests: XCTestCase {

    override func setUp() {
        super.setUp()
        LocalGoalManager.shared.deleteAll()
    }

    override func tearDown() {
        super.tearDown()
        LocalGoalManager.shared.deleteAll()
    }

    func testSaveGoals() {
        LocalGoalManager.shared.deleteAll()
        
        LocalGoalManager.shared.save(id: "1000", title: "Easy walk steps", description: "Walk 500 steps a day", type: "step", goal: 500, trophy: "bronze_medal", points: 5)
        LocalGoalManager.shared.save(id: "1001", title: "Medium walk steps", description: "Walk 1000 steps a day", type: "step", goal: 1000, trophy: "silver_medal", points: 10)
        
        let goals = LocalGoalManager.shared.getAll()
        XCTAssert(goals.count == 2)
    }
    
    func testDeleteAllSuggestions() {
        LocalGoalManager.shared.save(id: "1000", title: "Easy walk steps", description: "Walk 500 steps a day", type: "step", goal: 500, trophy: "bronze_medal", points: 5)
        LocalGoalManager.shared.save(id: "1001", title: "Medium walk steps", description: "Walk 1000 steps a day", type: "step", goal: 1000, trophy: "silver_medal", points: 10)
        
        LocalGoalManager.shared.deleteAll()
        
        let goals = LocalGoalManager.shared.getAll()
        XCTAssert(goals.count == 0)
    }
    
    func testOrderGoals() {
        LocalGoalManager.shared.deleteAll()
        
        LocalGoalManager.shared.save(id: "1001", title: "Medium walk steps", description: "Walk 1000 steps a day", type: "step", goal: 1000, trophy: "silver_medal", points: 10)
        LocalGoalManager.shared.save(id: "1000", title: "Easy walk steps", description: "Walk 500 steps a day", type: "step", goal: 500, trophy: "bronze_medal", points: 5)
        
        let goals = LocalGoalManager.shared.getAll()
        XCTAssert(goals[0].goalId == "1000" &&
            goals[1].goalId == "1001")
    }
    
    func testGoalExists() {
        LocalGoalManager.shared.deleteAll()
        
        LocalGoalManager.shared.save(id: "1000", title: "Easy walk steps", description: "Walk 500 steps a day", type: "step", goal: 500, trophy: "bronze_medal", points: 5)
        LocalGoalManager.shared.save(id: "1001", title: "Medium walk steps", description: "Walk 1000 steps a day", type: "step", goal: 1000, trophy: "silver_medal", points: 10)
        
        let goalExists = LocalGoalManager.shared.goalExists("1000")
        XCTAssert(goalExists == true, "The goal doesn't exist in the data base")
    }
    
    func testEmptyGoals() {
        LocalGoalManager.shared.deleteAll()
        let isEmpty = LocalGoalManager.shared.isEmpty()
        XCTAssert(isEmpty == true)
    }

}
