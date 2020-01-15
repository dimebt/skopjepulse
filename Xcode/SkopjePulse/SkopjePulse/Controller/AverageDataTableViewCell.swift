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
    }
}
