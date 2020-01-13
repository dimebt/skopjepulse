//
//  CityTableViewCell.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/13/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityImage: UIImageView!
    
    public func configure(with city: City) {
        self.cityLabel.text = city.name
        self.cityImage.image = UIImage(named: city.name)
    }
}
