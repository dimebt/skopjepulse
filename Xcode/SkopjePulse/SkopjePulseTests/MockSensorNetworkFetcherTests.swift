//
//  MockSensorNetworkFetcherTests.swift
//  SkopjePulseTests
//
//  Created by Dimitar Stefanovski on 1/16/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import XCTest
@testable import SkopjePulse

class MockSensorNetworkFetcherTests: XCTestCase {
    
    var sut: MockSensorNetworkFetcher!
    var city: City!
    var endpoint: URL!

    override func setUp() {
        sut = MockSensorNetworkFetcher()
        
        city = City(name: "Skopje")
        endpoint = EndpointFactory.create(for: city, endpoint: .Sensors)!
    }

    override func tearDown() {
        sut = nil
    }
    
    func testMockSensorNetworkFetcher_ShoudReturnResponseWithSensors() {
        sut.shoudReturnError = false
        sut.fetch(from: endpoint) { (results) in
            switch results {
            case .success(let sensors):
                XCTAssertNotNil(sensors)
            case .failure(_):
                XCTFail("Error shoud not be returned!")
            }
        }
    }
    
    func testMockSensorNetworkFetcher_ShoudReturnResponseWithFourSensors() {
        sut.shoudReturnError = false
        sut.fetch(from: endpoint) { (results) in
            switch results {
            case .success(let sensors):
                XCTAssertNotNil(sensors)
                XCTAssertEqual(sensors.count, 4)
            case .failure(_):
                XCTFail("Error shoud not be returned!")
            }
        }
    }
    
    func testMockSensorNetworkFetcher_ShoudReturnError() {
        sut.shoudReturnError = true
        sut.fetch(from: endpoint) { (results) in
            switch results {
            case .success(_):
                XCTFail("Response shoud not be retured!")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }

}
