//
//  CityStructTests.swift
//  SkopjePulseTests
//
//  Created by Dimitar Stefanovski on 1/14/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import XCTest
@testable import SkopjePulse

class CityStructTests: XCTestCase {
    
    var testCity: City!

    override func setUp() {
        
    }

    override func tearDown() {
        testCity = nil
    }

    func testInit_CityWithName() {
        testCity = City(name: "Singapore")
        XCTAssertNotNil(testCity)
        XCTAssertEqual(testCity.name, "Singapore")
    }
}
