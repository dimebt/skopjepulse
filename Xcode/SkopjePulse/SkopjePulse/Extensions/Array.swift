//
//  Array.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/15/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

extension Array where Element == Int {
    public func average(values: [Int]) -> Double {
        return Double(self.reduce(0, +)) / Double(values.count)
    }
    var average: Double {
        return (Double(self.reduce(0, +)) / Double(self.count)).rounded()
    }
}
