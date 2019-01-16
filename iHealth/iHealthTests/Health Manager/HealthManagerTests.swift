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
        
        HealthManager.shared.requestAuthorization { (success, error) in
            XCTAssertNotNil(error, "Error getting the user permission")
        }
    }

}
