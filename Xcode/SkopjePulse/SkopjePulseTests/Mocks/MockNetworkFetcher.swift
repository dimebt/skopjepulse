//
//  MockNetworkFetcher.swift
//  SkopjePulseTests
//
//  Created by Dimitar Stefanovski on 1/16/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation
@testable import SkopjePulse

class MockSensorNetworkFetcher {
    var fetchWasCalled = false
    var shoudReturnError = false
    var timeoutInterval = 30.0
    
    let stubSensors = [
        Sensor(sensorId: "0", position: "", comments: "", type: "pm10", description: "Sensor1", status: .active),
        Sensor(sensorId: "1", position: "", comments: "", type: "pm10", description: "Sensor2", status: .active),
        Sensor(sensorId: "2", position: "", comments: "", type: "pm10", description: "Sensor3", status: .active),
        Sensor(sensorId: "3", position: "", comments: "", type: "pm10", description: "Sensor4", status: .active)
    ]
}

enum MockSensorNetworkFetcherError: Error {
    case errorFetch
}

extension MockSensorNetworkFetcher: FetchService {    
    func fetch(from url: URL, completion: @escaping (Result<Sensors, Error>) -> Void) {
        fetchWasCalled = true
        
        if shoudReturnError {
            completion(.failure(MockSensorNetworkFetcherError.errorFetch))
        } else {
            completion(.success(stubSensors))
        }
    }
}
