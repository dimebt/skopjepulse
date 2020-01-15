//
//  Date.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/13/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

extension Date {
    public func before(hours: Int) -> Date? {
        return Calendar.current.date(byAdding: .hour, value: -hours, to: self)
    }
    public func convertToString(dateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
}
