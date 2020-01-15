//
//  SearchServiceTests.swift
//  SkopjePulseTests
//
//  Created by Dimitar Stefanovski on 1/15/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import XCTest
@testable import SkopjePulse

class SearchServiceTests: XCTestCase {
   
    var city1: City!
    var city2: City!
    var city3: City!
    var cities: [City]!
    var searchService: SearchService!

    override func setUp() {
        city1 = City(name: "Skopje")
        city2 = City(name: "Bitola")
        city3 = City(name: "Kavadarci")
        cities = [city1, city2, city3]
        searchService = SearchService()
    }

    override func tearDown() {
        cities = nil
    }
    
    func testSearchService_SearchForTerm_ABC_Returns_ZeroCountArray() {
        let searchTerm = "ABC"
        
        searchService.search(term: searchTerm, cities: cities)
        let queryResults = searchService.queryResults
        
        XCTAssertNotNil(queryResults)
        XCTAssertEqual(queryResults?.count, 0)
    }
    
    func testSearchService_SearchForTerm_a_Returns_TwoCities() {
        let searchTerm = "A"
        
        searchService.search(term: searchTerm, cities: cities)
        let queryResults = searchService.queryResults
        
        XCTAssertNotNil(queryResults)
        XCTAssertEqual(queryResults?.count, 2)
    }
    
    func testSearchService_SearchForTerm_B_Returns_Bitola() {
        let searchTerm = "B"
        
        searchService.search(term: searchTerm, cities: cities)
        let queryResults = searchService.queryResults
        
        XCTAssertNotNil(queryResults)
        XCTAssertGreaterThan(queryResults!.count, 0)
        
        let city = queryResults?.first
        XCTAssertNotNil(city)
        XCTAssertEqual(city?.name, "Bitola")
    }

    func testSearchService_SearchForTerm_Ka_Returns_Kavadarci() {
        let searchTerm = "Ka"
        
        searchService.search(term: searchTerm, cities: cities)
        let queryResults = searchService.queryResults
        
        XCTAssertNotNil(queryResults)
        XCTAssertGreaterThan(queryResults!.count, 0)
        
        let city = queryResults?.first
        XCTAssertNotNil(city)
        XCTAssertEqual(city?.name, "Kavadarci")
    }

}
