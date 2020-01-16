//
//  PulseUISearchBar.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/16/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class PulseUISearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        searchTextField.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        searchTextField.textColor = .white
    }
    
}
