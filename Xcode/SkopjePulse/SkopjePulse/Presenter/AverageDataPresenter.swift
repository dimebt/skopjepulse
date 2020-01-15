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
    private var endpoint: URL!
    public var cellIdentifier = "averageDataCell"
    private var fetchService: NetworkFetcher<SensorData>!
    
    init(city: City,
         sensor: Sensor,
         fetchService: NetworkFetcher<SensorData> = NetworkFetcher<SensorData>()) {
        self.city = city
        self.sensor = sensor
        self.fetchService = fetchService
        self.endpoint = EndpointFactory.create(for: city, endpoint: .Data24h)
    }
    
    public func fetchSensorData() {
        self.delegate?.loading()
        fetchService.fetch(from: endpoint) { (result) in
            switch result {
            case .success(let sensorData):
                self.processData(sensorData: sensorData, particleType: .pm10)                
                print("-------\(self.city.name) FETCHING SUCESSFULY -----------")
            case .failure(let error):
                print(error)
                print("------- ERROR FETCHING SENSOR VALUES DATA -----------")
            }
        }
    }
    
    private func processData(sensorData: SensorData, particleType: SensorTypeEnum) {
        guard let dateBefore6hours = Date().before(hours: 6) else { return }
        guard let dateBefore12hours = Date().before(hours: 12) else { return }
        let averagePast6h = sensorData.filter {
            $0.sensorId == self.sensor.sensorId &&
            $0.type == particleType &&
            $0.stamp > dateBefore6hours
            }.compactMap { Int($0.value) }
            .average
        let averagePast12h = sensorData.filter {
            $0.sensorId == self.sensor.sensorId &&
            $0.type == particleType &&
            $0.stamp > dateBefore12hours
            }.compactMap { Int($0.value) }
            .average
        let averagePast24h = sensorData.filter {
            $0.sensorId == self.sensor.sensorId &&
            $0.type == particleType
            }.compactMap { Int($0.value) }
            .average
        
        print(averagePast6h)
        print(averagePast12h)
        print(averagePast24h)
                
        let past6 = AverageData(
            description: .past6,
            averageValue: averagePast6h,
            increeseIcon: .up)
        
        let past12 = AverageData(
            description: .past12,
            averageValue: averagePast12h,
            increeseIcon: .up)
        
        let past24 = AverageData(
            description: .past24,
            averageValue: averagePast24h,
            increeseIcon: .up)
        let data = [past6, past12, past24]
        
        delegate?.finishedLoading(averageData: data)
    }
 
    public func getSensorTitle() -> String {
        return sensor.description
    }
    
    
}
