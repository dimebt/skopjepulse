//
//  SensorDataService.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/16/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

//  MARK: - SensorDataService for processing the fetched data from the REST API ednpoints
class SensorDataService {
    
    public var averageData: [AverageData]!
    
    /// Processing sensors data for selected Particles
    /// - Parameters:
    ///   - sensor: Sensor model object
    ///   - sensorData: Sensor data model object
    ///   - particleType: Particle type enum
    public func processData(sensor: Sensor, sensorData: SensorData, particleType: SensorTypeEnum) {
        
        /// Get date before 6 hours
        guard let dateBefore6hours = Date().before(hours: 6) else { return }
        /// Get date before 12 hours
        guard let dateBefore12hours = Date().before(hours: 12) else { return }
        
        /// Filter the sensor data for the past 6 hours and calculate average
        let averagePast6h = sensorData.filter {
            $0.sensorId == sensor.sensorId &&
            $0.type == particleType &&
            $0.stamp > dateBefore6hours
            }.compactMap { Int($0.value) }
            .average
        
        /// Filter the sensor data for the past 12 hours and calculate average
        let averagePast12h = sensorData.filter {
            $0.sensorId == sensor.sensorId &&
            $0.type == particleType &&
            $0.stamp > dateBefore12hours
            }.compactMap { Int($0.value) }
            .average
        
        /// Filter the sensor data for the past 24 hours and calculate average
        let averagePast24h = sensorData.filter {
            $0.sensorId == sensor.sensorId &&
            $0.type == particleType
            }.compactMap { Int($0.value) }
            .average
        
        /// Computed enum property for geting the state of the icon arrow depending of the average values of the previous period
        var past6hComparedTopast12: AverageIncreeseIcon {
            if averagePast6h > averagePast12h {
                return .up
            } else {
                return .down
            }
        }
        
        /// Computed enum property for geting the state of the icon arrow depending of the average values of the previous period
        var past12hComparedTopast24: AverageIncreeseIcon {
            if averagePast12h > averagePast24h {
                return .up
            } else {
                return .down
            }
        }
        
        /// Agregating data into Array for easy displaying on the TableView
        let past6 = AverageData(
            description: .past6,
            averageValue: averagePast6h,
            increeseIcon: past6hComparedTopast12,
            particleType: particleType)
        
        let past12 = AverageData(
            description: .past12,
            averageValue: averagePast12h,
            increeseIcon: past12hComparedTopast24,
            particleType: particleType)
        
        let past24 = AverageData(
            description: .past24,
            averageValue: averagePast24h,
            increeseIcon: .noimage,
            particleType: particleType)
        let data = [past6, past12, past24]
        
        self.averageData = data        
    }
}
