//
//  SensorStateDelegate.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/14/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

protocol SensorCellDelegate: class {
    func toggle(sensor: Sensor, with state: SensorState)
}
