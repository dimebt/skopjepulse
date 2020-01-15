//
//  SensorDataGlobalCache.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/15/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

class SensorDataCache {
    public static let shared = SensorDataCache()
    private var data = [City: SensorData]()
    private init() { }
    
    public func setData(for city: City, with data: SensorData) {
        self.data[city] = data
    }
    
    public func getData(for city: City) -> SensorData? {
        guard let data = self.data[city] else { return nil }
        return data
    }
}
