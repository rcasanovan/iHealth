//
//  NetworkTests.swift
//  iHealthTests
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import XCTest
@testable import iHealth

typealias goalsCompletionBlock = (Result<GoalsResponse?>) -> Void

class NetworkTests: XCTestCase {
    
    private let requestManager = RequestManager()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetGoals(simulatedJSONFile: String? = nil, completion: @escaping goalsCompletionBlock) {
        var goalsRequest = GoalsRequest()
        
        goalsRequest.completion = completion
        goalsRequest.verbose = true
        goalsRequest.simulatedResponseJSONFile = simulatedJSONFile
        requestManager.send(request: goalsRequest)
    }

    func testGetGoalsList() {
        let goalsExpectation: XCTestExpectation = self.expectation(description: "goalsExpectation")
        
        testGetGoals { (response) in
            switch response {
            case .success(let goalsResponse):
                XCTAssertNotNil(goalsResponse, "Impossible to get the goals response")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            goalsExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 25.0, handler: nil)
    }
    
    func testSimulatedGetGoalsList() {
        let goalsExpectation: XCTestExpectation = self.expectation(description: "goalsExpectation")
        
        testGetGoals(simulatedJSONFile: "Goals") { (response) in
            switch response {
            case .success(let goalsResponse):
                XCTAssertNotNil(goalsResponse, "Impossible to get the goals response")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            goalsExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 25.0, handler: nil)
    }

}
