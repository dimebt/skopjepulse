//
//  SearchService.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/15/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation


protocol SearchService {
    associatedtype T
    var queryResults: T? { get set }
    func search(term: String, bag: T)
}


class CitySearchService {
    
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

class SensorSearchService {
    
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

