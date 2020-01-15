//
//  SensorState.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/14/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

enum SensorState: String {
    case disabled
    case enabled
    
    mutating func toggle() -> Self{
        if self == .disabled {
            return .enabled
        } else {
            return .disabled
        }
    }
}
