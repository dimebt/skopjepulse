//
//  String.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/13/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

extension String {
    public func convertToDate(dateFormat: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        guard let date = formatter.date(from: self) else { return nil }
        return date
    }
    
    public var capitalFirstLetter: String {
        return prefix(1).capitalized + dropFirst()
    }
}
