//
//  SensorTableViewCell.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/13/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class SensorTableViewCell: UITableViewCell {

    @IBOutlet weak var sensorTitle: UILabel!
    @IBOutlet weak var disableSensor: UIButton!
    @IBOutlet weak var sensorActivity: UIButton!
    
    public func configure(with sensor: Sensor) {
        self.sensorTitle.text = sensor.description
    }
    
}
