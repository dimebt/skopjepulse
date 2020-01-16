//
//  SensorValuesMeasurementsTests.swift
//  SkopjePulseTests
//
//  Created by Dimitar Stefanovski on 1/16/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import XCTest
@testable import SkopjePulse

class SensorValuesMeasurementsTests: XCTestCase {
    
    var sut1: SensorValue!
    var sut2: SensorValue!
    var sut3: SensorValue!
    var sut4: SensorValue!
    var sut5: SensorValue!
    var sut6: SensorValue!
    
    
    override func setUp() {
        sut1 = SensorValue(sensorId: "", stamp: Date(), type: .humidity, position: "", value: "")
        sut2 = SensorValue(sensorId: "", stamp: Date(), type: .noise, position: "", value: "")
        sut3 = SensorValue(sensorId: "", stamp: Date(), type: .pm10, position: "", value: "")
        sut4 = SensorValue(sensorId: "", stamp: Date(), type: .pm25, position: "", value: "")
        sut5 = SensorValue(sensorId: "", stamp: Date(), type: .pressure, position: "", value: "")
        sut6 = SensorValue(sensorId: "", stamp: Date(), type: .temperature, position: "", value: "")
    }
    
    override func tearDown() {
        
    }
    
    func testMeasurementUnitLabels_ForGivenEnum() {
        XCTAssertEqual(sut1.type.mesurementUnits, "%")
        XCTAssertEqual(sut2.type.mesurementUnits, "units")
        XCTAssertEqual(sut3.type.mesurementUnits, "μg/m3")
        XCTAssertEqual(sut4.type.mesurementUnits, "μg/m3")
        XCTAssertEqual(sut5.type.mesurementUnits, "hPa")
        XCTAssertEqual(sut6.type.mesurementUnits, "°C")
    }   
    
}
