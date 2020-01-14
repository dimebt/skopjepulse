//
//  CitiesDataServiceTests.swift
//  SkopjePulseTests
//
//  Created by Dimitar Stefanovski on 1/14/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import XCTest
@testable import SkopjePulse

class CitiesDataServiceTests: XCTestCase {
    
    var sut: CitiesDataService!
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testInit_CitiesDataServiceWithCities() {
        let citiesStub = [City(name: "Skopje")]
        sut = CitiesDataService(cities: citiesStub)
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.cities.first?.name, citiesStub.first?.name)
    }
    
    func testCitiesCount_in_CitiesDataService_With_NoCities() {
        let citiesStub: [City] = []
        sut = CitiesDataService(cities: citiesStub)
        XCTAssertNotNil(sut.citiesCount)
        XCTAssertEqual(sut.citiesCount, 0)
    }
    
    func testCitiesCount_in_CitiesDataService_With_Cities() {
        let city1 = City(name: "Ohrid")
        let city2 = City(name: "Strumica")
        let citiesStub = [city1, city2]
        sut = CitiesDataService(cities: citiesStub)
        XCTAssertEqual(sut.citiesCount, 2)
    }
    
    func testTableView_Returns_RowCount_0_ForNoCities() {
        let citiesStub: [City] = []
        sut = CitiesDataService(cities: citiesStub)
        let tableView = UITableView()
        tableView.dataSource = sut
        
        let rows = tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(rows, 0)
    }
    
    func testTableView_Returns_RowCount_1_ForOneCity() {
        let city1 = City(name: "Prilep")
        let citiesStub = [city1]
        sut = CitiesDataService(cities: citiesStub)
        let tableView = UITableView()
        tableView.dataSource = sut
        
        let rows = tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(rows, 1)
    }
    
    func testTableView_Returns_RowCount_3_ForThreeCities() {
        let city1 = City(name: "Prilep")
        let city2 = City(name: "Oslo")
        let city3 = City(name: "Cologne")
        let citiesStub = [city1, city2, city3]
        sut = CitiesDataService(cities: citiesStub)
        let tableView = UITableView()
        tableView.dataSource = sut
        
        let rows = tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(rows, 3)
    }
    
    func testTableView_CellForRowAt_Returns_CityTableViewCell() {
        let city1 = City(name: "Prilep")
        let citiesStub = [city1]
        sut = CitiesDataService(cities: citiesStub)
        let tableView = UITableView()
        let cityCell = UINib(nibName: "CityCell", bundle: nil)
        tableView.register(cityCell, forCellReuseIdentifier: sut.cellIdentifier)
        tableView.dataSource = sut
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(item: 0, section: 0))
        XCTAssertNotNil(cell)
        XCTAssertTrue(cell is CityTableViewCell)        
    }
    
    func testTableView_dequeueReusableCell_IsCalled() {
        let city1 = City(name: "Prilep")
        let citiesStub = [city1]
        sut = CitiesDataService(cities: citiesStub)
        let mockTableView = MockCitiesTableView()
        let cityCell = UINib(nibName: "CityCell", bundle: nil)
        mockTableView.register(cityCell, forCellReuseIdentifier: sut.cellIdentifier)
        mockTableView.dataSource = sut
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(item: 0, section: 0))
        XCTAssertTrue(mockTableView.dequeueReusableCellisCalled)
    }
    
    
    
    
}
