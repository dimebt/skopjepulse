//
//  AverageDataPresenter.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/14/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

protocol AverageDataPresenterDelegate: class {
    func loading()
    func finishedLoading(averageData: [AverageData])
}

class AverageDataPresenter {
    
    weak var delegate: AverageDataPresenterDelegate?
    private var city: City!
    private var sensor: Sensor!
    private var sensorData: SensorData!
    private var sensorDataService: SensorDataService!
    public var cellIdentifier = "averageDataCell"
    public var averageData: [AverageData]!
    
    init(city: City,
         sensor: Sensor,
         sensorData: SensorData,
         sensorDataService: SensorDataService = SensorDataService()) {
        self.city = city
        self.sensor = sensor
        self.sensorData = sensorData
        self.sensorDataService = sensorDataService
    }
    
    //  MARK: - By defaults will Pm10 measurements will be loaded and notify the delegate
    public func processDefaultPm10() {
        sensorDataService.processData(sensor: self.sensor, sensorData: self.sensorData, particleType: .pm10)
        self.averageData = sensorDataService.averageData
        delegate?.finishedLoading(averageData: self.averageData)
    }
    
    //  MARK: - Will load measurements data for selected particles on the segmentet control and notify the delegate
    public func processAverageData(for segmentSelection: Int) {
        var particleType = SensorTypeEnum.pm10
        switch segmentSelection {
        case 0:
            particleType = .pm10
        case 1:
            particleType = .pm25
        case 2:
            particleType = .humidity
        case 3:
            particleType = .noise
        case 4:
            particleType = .pressure
        case 5:
            particleType = .temperature
        default:
            particleType = .pm10
        }
        sensorDataService.processData(sensor: self.sensor, sensorData: self.sensorData, particleType: particleType)
        self.averageData = sensorDataService.averageData
        delegate?.finishedLoading(averageData: self.averageData)
    }
 
    //  MARK: - Geter for the sensor description
    public func getSensorTitle() -> String {
        return sensor.description
    }
    
    
}
