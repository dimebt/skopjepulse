//
//  SensorsViewModel.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/13/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import UIKit

protocol SensorsView: class {
    func startLoading()
    func finishLoading(with sensors: Sensors)
    func sensorStateSaved()
    func showSensorDetails(sensor: Sensor)
    func errorFetching(error: Error)
}

class SensorsPresenter: NSObject {
    
    weak var delegate: SensorsView?
    
    private var city: City!
    private var fetchService: NetworkFetcher<Sensors>!
    private var apiEndpoint: URL!
    private var sensorState = [String: SensorState]()
    
    public var cellIdentifier = "sensorCell"
    
    init(fetchService: NetworkFetcher<Sensors> = NetworkFetcher<Sensors>(),         
         city: City) {
        self.fetchService = fetchService
        self.city = city
        self.apiEndpoint = EndpointFactory.create(for: city, endpoint: .Sensors)
    }
    
    public func fetchSensors() {
        delegate?.startLoading()
        fetchService.fetch(from: apiEndpoint) { (result) in
            switch result {
            case .success(let sensors):
                self.delegate?.finishLoading(with: sensors)
            case .failure(let error):
                self.delegate?.errorFetching(error: error)
            }
        }
    }
    
    public func fetchSensorState() {
       
    }
    
    public func getSensorState(for sensor: Sensor) -> SensorState {
        guard let state = sensorState[sensor.sensorId] else { return .enabled }
        return state
    }
    
    public func setSensorState(for sensor: Sensor, state: SensorState) {
        sensorState[sensor.sensorId] = state
        delegate?.sensorStateSaved()
    }
    
    public func tapOnSensor(sensor: Sensor) {
        if !sensorDisabled(sensor: sensor) {
            delegate?.showSensorDetails(sensor: sensor)
        }
    }
    
    public func sensorDisabled(sensor: Sensor) -> Bool {
        let current = getSensorState(for: sensor)
        switch current {
        case .disabled:
            return true
        case .enabled:
            return false
        }
    }
}
