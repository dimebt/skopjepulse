//
//  SensorTableViewCell.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/13/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import UIKit

protocol SensorCellDelegate: class {
    func toggle(sensor: Sensor, with state: SensorState)
}

class SensorTableViewCell: UITableViewCell {
    
    private var state: SensorState = .enabled
    private var sensor: Sensor!
    
    weak var delegate: SensorCellDelegate?

    @IBOutlet weak var sensorTitle: UILabel!
    @IBOutlet weak var disableSensor: UIButton!
    @IBOutlet weak var sensorActivity: UIButton!
    @IBOutlet weak var grayView: UIView!
    
    public func configure(with sensor: Sensor) {
        self.sensorTitle.text = sensor.description
        self.sensor = sensor
        switch sensor.status {
        case .active:
            self.sensorActivity.tintColor = .systemBlue
        default:
            self.sensorActivity.tintColor = .darkText
        }
    }
    
    public func configureState(state: SensorState) {
        self.state = state
        switch state {
        case .disabled:
            self.grayView.isHidden = false
            self.disableSensor.tintColor = UIColor.gray
        case .enabled:
            self.grayView.isHidden = true
            self.disableSensor.isEnabled = true
            self.disableSensor.tintColor = UIColor.green
        }
    }
    
    @IBAction func disablePressed(_ sender: Any) {
        delegate?.toggle(sensor: self.sensor, with: self.state.toggle())
    }
    
    
}
