//
//  NetworkFetcherTests.swift
//  SkopjePulseTests
//
//  Created by Dimitar Stefanovski on 1/16/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import XCTest
@testable import SkopjePulse

class NetworkFetcherTests: XCTestCase {
    
    var sut: NetworkFetcher<Sensors>!
    

    override func setUp() {
        sut = NetworkFetcher<Sensors>()
    }

    override func tearDown() {
        sut = nil
    }

    func testNetworkFetcher_ShoudReturnResponseForValidRequests() {
        let expectation = self.expectation(description: "Successfuly fetching sensors json response with expectation of 5s.")
        let city = City(name: "Bitola")
        let endpoint = EndpointFactory.create(for: city, endpoint: .Sensors)!
        sut.fetch(from: endpoint) { (result) in
            switch result {
            case .success(let sensors):
                XCTAssertNotNil(sensors)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testNetworkFetcher_ShoudReturnErrorForInvalidRequests() {
        let expectation = self.expectation(description: "Shoud return error for bad request with expectation of 5.")
        let city = City(name: "FakeCity")
        let endpoint = EndpointFactory.create(for: city, endpoint: .Sensors)!
        sut.fetch(from: endpoint) { (result) in
            switch result {
            case .success(_):
                XCTFail("Fetcher return some data for a fake requests!")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testNetworkFetcher_ShoudReturnErrorAfterRequestTimeout() {
        sut.timeoutInterval = 0.2
        let expectation = self.expectation(description: "Expecting to return error after request timeout!")
        let city = City(name: "Skopje")
        let endpoint = EndpointFactory.create(for: city, endpoint: .Sensors)!
        sut.fetch(from: endpoint) { (results) in
            switch results {
            case .success(_):
                XCTFail("Response shoud not be recived after the timeout!")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 2, handler: nil)
    }
}
