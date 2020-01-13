//
//  Sensor.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/12/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

// MARK: - Sensor Model
struct Sensor: Codable {
    let sensorId: String
    let position: String
    let comments: String
    let type: String
    let description: String
    let status: String

    enum CodingKeys: String, CodingKey {
        case sensorId, position, comments, type, description, status
    }
}

typealias Sensors = [Sensor]
