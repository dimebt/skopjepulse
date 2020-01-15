//
//  SensorStatePersistable.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/14/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

protocol SensorStatePersistable {
    func save(sensorState: [String: SensorState])
    func load(form sensor: Sensor, completion: @escaping (Result<Bool, Error>) -> Void )
}
