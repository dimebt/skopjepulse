//
//  AverageDataPresenter.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/14/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

class AverageDataPresenter {
    private var sensor: Sensor!
    public var cellIdentifier = "averageDataCell"
    
    init(sensor: Sensor) {
        self.sensor = sensor
    }
    
    public func getSensorTitle() -> String {
        return sensor.description
    }
}
