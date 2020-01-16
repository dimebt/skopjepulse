//
//  SensorDataServiceTests.swift
//  SkopjePulseTests
//
//  Created by Dimitar Stefanovski on 1/16/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import XCTest
@testable import SkopjePulse

class SensorDataServiceTests: XCTestCase {
    
    var sensorDataService: SensorDataService!
    var sensorData: SensorData!
    var sensor1: Sensor!
    var sensor2: Sensor!
    var sensor3: Sensor!
    var sensor4: Sensor!
    var sensor5: Sensor!
    var sensor6: Sensor!
    var date1: Date!
    var date2: Date!
    var date3: Date!
    
    override func setUp() {
        
        sensorDataService = SensorDataService()
        
        sensor1 = Sensor(sensorId: "1", position: "", comments: "", type: "", description: "", status: .active)
        sensor2 = Sensor(sensorId: "2", position: "", comments: "", type: "", description: "", status: .active)
        sensor3 = Sensor(sensorId: "3", position: "", comments: "", type: "", description: "", status: .active)
        sensor4 = Sensor(sensorId: "4", position: "", comments: "", type: "", description: "", status: .active)
        sensor5 = Sensor(sensorId: "5", position: "", comments: "", type: "", description: "", status: .active)
        sensor6 = Sensor(sensorId: "6", position: "", comments: "", type: "", description: "", status: .active)
        
        
        
        let sut1 = SensorValue(sensorId: "1", stamp: Date().before(hours: 2)!, type: .pm10, position: "", value: "40")
        let sut2 = SensorValue(sensorId: "1", stamp: Date().before(hours: 2)!, type: .pm10, position: "", value: "40")
        let sut3 = SensorValue(sensorId: "3", stamp: Date().before(hours: 2)!, type: .pm25, position: "", value: "3")
        let sut4 = SensorValue(sensorId: "4", stamp: Date().before(hours: 8)!, type: .pm25, position: "", value: "4")
        let sut5 = SensorValue(sensorId: "1", stamp: Date().before(hours: 8)!, type: .pm10, position: "", value: "80")
        let sut6 = SensorValue(sensorId: "1", stamp: Date().before(hours: 8)!, type: .pm10, position: "", value: "80")
        let sut7 = SensorValue(sensorId: "7", stamp: Date().before(hours: 8)!, type: .pm25, position: "", value: "7")
        let sut8 = SensorValue(sensorId: "8", stamp: Date().before(hours: 15)!, type: .temperature, position: "", value: "8")
        let sut9 = SensorValue(sensorId: "1", stamp: Date().before(hours: 15)!, type: .pm10, position: "", value: "100")
        let sut10 = SensorValue(sensorId: "10", stamp: Date().before(hours: 15)!, type: .humidity, position: "", value: "10")
        
        sensorData = [
            sut1,
            sut2,
            sut3,
            sut4,
            sut5,
            sut6,
            sut7,
            sut8,
            sut9,
            sut10
        ]
    }
    
    override func tearDown() {
        sensorDataService = nil
        sensorData = nil
        sensor1 = nil
        sensor2 = nil
        sensor3 = nil
        sensor4 = nil
        sensor5 = nil
        sensor6 = nil
    }
    
    func testSensorDataService_FilterData_ForGivenSensor() {
        sensorDataService.processData(sensor: sensor1, sensorData: sensorData, particleType: .pm10)
        let sutAverageDataLast6 = sensorDataService.averageData[0]
        let sutAverageDataLast12 = sensorDataService.averageData[1]
        let sutAverageDataLast24 = sensorDataService.averageData[2]
        
        XCTAssertEqual(sutAverageDataLast6.averageValue, 40.0)
        XCTAssertEqual(sutAverageDataLast12.averageValue, 60.0)
        XCTAssertEqual(sutAverageDataLast24.averageValue, 68.0)
    }
    
    
}
