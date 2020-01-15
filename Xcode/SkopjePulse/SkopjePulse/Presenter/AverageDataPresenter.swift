//
//  AverageDataPresenter.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/14/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

protocol AverageDataPresenterDelegate {
    func loading()
    func finishedLoading()
}

class AverageDataPresenter {
    private var sensor: Sensor!
    public var cellIdentifier = "averageDataCell"
    
    init(sensor: Sensor) {
        self.sensor = sensor
    }
    
    public func getSensorTitle() -> String {
        return sensor.description
    }
    
    public func fetch() {        
        let endpoint = EndpointFactory.create(for: city, endpoint: .Data24h)
        let fetcher = NetworkFetcher<SensorData>()
        fetcher.fetch(from: endpoint!) { (result) in
            switch result {
            case .success(let sensorData):
                //print(sensorData)
                SensorDataCache.shared.setData(for: city, with: sensorData)
                print("-------\(city.name) FETCHING SUCESSFULY -----------")
            case .failure(let error):
                print(error)
                print("------- ERROR FETCHING SENSOR VALUES DATA -----------")
            }
        }

    }
}
