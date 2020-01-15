//
//  AverageData.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/15/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

struct AverageData {
    
    let description: AverageLabelDescription
    let averageValue: Double
    let increeseIcon: AverageIncreeseIcon
    let particleType: SensorTypeEnum
    
    public var gatAverageValue: String {
        guard let average = averageValue.int else { return "- \(particleType.mesurementUnits)"}
        return "\(average) \(particleType.mesurementUnits)"
    }
    
    public var getMeasurementType: String {
        return particleType.rawValue.capitalFirstLetter
    }
    
}

enum AverageIncreeseIcon: String {
    case up
    case down
    case equal
    case noimage
}

enum AverageLabelDescription: String {
    case past6 = "Average data for the past 6 hours"
    case past12 = "Average data for the past 12 hours"
    case past24 = "Average data for the past 24 hours"
}
