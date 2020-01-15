//
//  Double.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/15/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

extension Double {
    var int: Int? {
        if self >= Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        } else {
            return nil
        }
    }
}
