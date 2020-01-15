//
//  SensorData.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/12/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

// MARK: - SensorData Model
struct SensorValue: Codable {
    let sensorId: String
    let stamp: Date
    let type: SensorTypeEnum
    let position: String
    let value: String

    enum CodingKeys: String, CodingKey {
        case sensorId, stamp, type, position, value
    }
}

enum SensorTypeEnum: String, Codable {
    case humidity = "humidity"
    case noise = "noise"
    case pm10 = "pm10"
    case pm25 = "pm25"
    case pressure = "pressure"
    case temperature = "temperature"
    
    var mesurementUnits: String {
        switch self {
        case .humidity:
            return "%"
        case .noise:
            return "units"
        case .pm10:
            return "μg/m3"
        case .pm25:
            return "μg/m3"
        case .pressure:
            return "hPa"
        case .temperature:
            return "°C"
        }
    }
}

typealias SensorData = [SensorValue]
