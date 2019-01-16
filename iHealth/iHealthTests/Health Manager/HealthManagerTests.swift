//
//  HealthManagerTests.swift
//  iHealthTests
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import XCTest
@testable import iHealth

class HealthManagerTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSharedInstance() {
        XCTAssertNotNil(HealthManager.shared, "Impossible to get the shared instance")
    }
    
    func testRequestAuthorization() {
        XCTAssert(Device.isSimulator == false, "You need to run the app in a real device")
        
        let authExpectation: XCTestExpectation = self.expectation(description: "authExpectation")
        
        HealthManager.shared.requestAuthorization { (success, error) in
            XCTAssertNil(error, "Error getting the user permission")
            authExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 25.0, handler: nil)
    }
    
    func testGetSteps() {
        XCTAssert(Device.isSimulator == false, "You need to run the app in a real device")
        
        let stepsExpectation: XCTestExpectation = self.expectation(description: "stepsExpectation")
        
        HealthManager.shared.requestAuthorization { (success, error) in
            XCTAssertNil(error, "Error getting the user permission")
            HealthManager.shared.getSteps(completion: { (steps, success, error) in
                XCTAssertTrue(success, "Error getting the user steps")
                stepsExpectation.fulfill()
            })
        }
        
        self.waitForExpectations(timeout: 25.0, handler: nil)
    }

}
