//
//  SensorState.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/14/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

//  MARK: - SensorState Model
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

extension SensorState {
    var corespondingBoolState: Bool {
        switch self {
        case .disabled:
            return false
        case .enabled:
            return true
        }
    }
}
