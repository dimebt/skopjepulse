//
//  SearchService.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/15/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import Foundation

class SearchService {
    
    var queryResults: [City]?
    
    public func search(term: String, cities: [City]) {
        let searchTerm = term.lowercased()
        self.queryResults = cities.filter { $0.name.lowercased().contains(searchTerm) }
    }
}
