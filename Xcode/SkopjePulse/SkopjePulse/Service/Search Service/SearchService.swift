//
//  SearchService.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/15/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

//  MARK: - Protocol that has search functionality for associated type
// I'm using for implementing search functionality of the cities and sensors
protocol SearchService {
    associatedtype T
    var queryResults: T? { get set }
    func search(term: String, bag: T)
}

//  MARK: - Search service for searching a [City]
class CitySearchService: SearchService {
    
    var queryResults: [City]?
    
    public func search(term: String, bag: [City]) {
        if term.count == 0 {
            self.queryResults = bag
        } else {
            let searchTerm = term.lowercased()
            self.queryResults = bag.filter { $0.name.lowercased().contains(searchTerm) }
        }
        
    }
}

//  MARK: - Search service for searching a [Sensor]
class SensorSearchService: SearchService {
    
    var queryResults: Sensors?
    
    public func search(term: String, bag: Sensors) {
        if term.count == 0 {
            self.queryResults = bag
        } else {
            let searchTerm = term.lowercased()
            self.queryResults = bag.filter { $0.description.lowercased().contains(searchTerm) }
        }
        
    }
}

