//
//  DateBuilder.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/13/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

class DateBuilder {
    
    private var date: Date!
    
    public var year: Int = 0
    private var month: Int = 0
    private var day: Int = 0
    private var hour: Int = 0
    private var minute: Int = 0
    private var second: Int = 0
    
    
    /// Build the date with year
    /// - Parameter year: Int number defining the year
    func year(_ year: Int) -> Self {
        self.year = year
        return self
    }
    func month(_ month: Int) -> Self {
        self.month = month
        return self
    }
    func day(_ day: Int) -> Self {
        self.day = day
        return self
    }
    func hour(_ hour: Int) -> Self {
        self.hour = hour
        return self
    }
    func minute(_ minute: Int) -> Self {
        self.minute = minute
        return self
    }
    func second(_ second: Int) -> Self {
        self.second = second
        return self
    }
    func getTimeInterval() -> TimeInterval {
        return self.date.timeIntervalSinceNow
    }
    func getDate() -> Date {
        return self.date
    }
    
    func build() -> Self {
        var components = DateComponents()
        components.year = self.year
        components.month = self.month
        components.day = self.day
        components.hour = self.hour
        components.minute = self.minute
        components.second = self.second
        
        let calendar = Calendar.current
        self.date = calendar.date(from: components) ?? Date()
        return self
    }
}
