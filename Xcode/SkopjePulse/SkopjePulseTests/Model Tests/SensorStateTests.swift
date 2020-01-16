//
//  SensorStateTests.swift
//  SkopjePulseTests
//
//  Created by Dimitar Stefanovski on 1/16/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import XCTest
@testable import SkopjePulse

class SensorStateTests: XCTestCase {
    
    var sut: SensorState!
    
    override func setUp() {
        sut = .enabled
    }

    override func tearDown() {
        sut = nil
    }

    func testSensorState_Toggle_ShoudInvertState() {
        XCTAssertNotEqual(sut, sut.toggle())
        XCTAssertEqual(sut.toggle(), SensorState.disabled)
    }
    
    func testSensorState_ReturningOfCorespondingBool() {
        sut = .disabled
        XCTAssertEqual(sut.corespondingBoolState, false)
        sut = .enabled
        XCTAssertEqual(sut.corespondingBoolState, true)
    }


}
