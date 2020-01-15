//
//  AverageDataTableViewCell.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/14/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class AverageDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var averageValueLabel: UILabel!
    @IBOutlet weak var increeseIcon: UIImageView!
    
    
    public func configure(with averageData: AverageData) {
        self.descriptionLabel.text = averageData.description.rawValue
        self.averageValueLabel.text = averageData.gatAverageValue
        switch averageData.increeseIcon {
        case .up:
            self.increeseIcon.isHidden = false
            self.increeseIcon.image = UIImage(named: averageData.increeseIcon.rawValue)
        case .down:
            self.increeseIcon.isHidden = false
            self.increeseIcon.image = UIImage(named: averageData.increeseIcon.rawValue)
        case .equal:
            self.increeseIcon.isHidden = true
        case .noimage:
            self.increeseIcon.isHidden = true
        }
    }
}
