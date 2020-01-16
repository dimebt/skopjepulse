//
//  AverageArrayExtensionTests.swift
//  SkopjePulseTests
//
//  Created by Dimitar Stefanovski on 1/15/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import XCTest
@testable import SkopjePulse

class AverageArrayExtensionTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        
    }

    func testAverageForGivenInput123() {
        let stubs = [1, 2, 3]
        let sut = stubs.average(values: stubs)
        
        XCTAssertEqual(sut, 2)
    }
    
    func testAverageForGivenInput3333() {
        let stubs = [3, 3, 3, 3]
        let sut = stubs.average(values: stubs)
        
        XCTAssertEqual(sut, 3)
    }

  

}
