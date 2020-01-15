//
//  asdd.swift
//  SkopjePulseTests
//
//  Created by Dimitar Stefanovski on 1/13/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import XCTest
@testable import SkopjePulse

class TestStringToDateConversion: XCTestCase {

  func testGivenStingDateConversionToDateNotNil() {
        let stringDate = "2020-01-12T11:16:50+01:00"
        let sut = stringDate.convertToDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
        XCTAssertNotNil(sut)
    }
    
    func testGivenCoruptedStingDateConversionToDateIsNil() {
        let stringDate = "201-01-12T11:16:50+01:00"
        let sut = stringDate.convertToDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
        XCTAssertNotNil(sut)
    }

    func testGivenStringDateConversionToDate_1() {
        let stringDate = "2020-01-12T11:16:50+01:00"
        let sut = stringDate.convertToDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ")?.timeIntervalSinceNow
        let stub = DateBuilder()
            .year(2020)
            .month(1)
            .day(12)
            .hour(11)
            .minute(16)
            .second(50)
            .build()
            .getTimeInterval()
        
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut!, stub, accuracy: 0.002)
    }
    
    func testGivenStringDateConversionToDate_2() {
        let stringDate = "2020-01-12T11:32:21+01:00"
        let sut = stringDate.convertToDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ")?.timeIntervalSinceNow
        let stub = DateBuilder()
            .year(2020)
            .month(1)
            .day(12)
            .hour(11)
            .minute(32)
            .second(21)
            .build()
            .getTimeInterval()
        
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut!, stub, accuracy: 0.002)
    }
    

}
