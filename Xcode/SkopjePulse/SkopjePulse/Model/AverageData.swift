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
    
    public var gatAverageValue: String {
        guard let average = averageValue.int else { return "- μg/m3"}
        return "\(average) μg/m3"
    }
}

enum AverageIncreeseIcon {
    case up
    case down
}

enum AverageLabelDescription: String {
    case past6 = "Average data for the past 6 hours"
    case past12 = "Average data for the past 12 hours"
    case past24 = "Average data for the past 24 hours"
}
