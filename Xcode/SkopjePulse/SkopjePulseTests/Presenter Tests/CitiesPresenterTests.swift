//
//  CitiesPresenterTests.swift
//  SkopjePulseTests
//
//  Created by Dimitar Stefanovski on 1/14/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import XCTest
@testable import SkopjePulse

class CitiesPresenterTests: XCTestCase {
    
    var sut: CitiesPresenter!
    var citiesVC: CitiesViewController!
    
    override func setUp() {
        citiesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CitiesViewController") as? CitiesViewController
        let presenter = CitiesPresenter()
        citiesVC.presenter = presenter
        _ = citiesVC.view
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testInit_CitiesPresenterWithCities() {
        let citiesStub = [City(name: "Skopje")]
        sut = CitiesPresenter(cities: citiesStub)
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.cities.first?.name, citiesStub.first?.name)
    }
    
    func testCitiesCount_in_CitiesPresenter_With_NoCities() {
        let citiesStub: [City] = []
        sut = CitiesPresenter(cities: citiesStub)
        XCTAssertNotNil(sut.citiesCount)
        XCTAssertEqual(sut.citiesCount, 0)
    }
    
    func testCitiesCount_in_CitiesPresenter_With_Cities() {
        let city1 = City(name: "Ohrid")
        let city2 = City(name: "Strumica")
        let citiesStub = [city1, city2]
        sut = CitiesPresenter(cities: citiesStub)
        XCTAssertEqual(sut.citiesCount, 2)
    }
    
    func testTableView_CellForRowAt_Returns_CityTableViewCell() {
        let city1 = City(name: "Prilep")
        let citiesStub = [city1]
        sut = CitiesPresenter(cities: citiesStub)
        let tableView = UITableView()
        let cityCell = UINib(nibName: "CityCell", bundle: nil)
        tableView.register(cityCell, forCellReuseIdentifier: sut.cellIdentifier)
        tableView.dataSource = citiesVC
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(item: 0, section: 0))
        XCTAssertNotNil(cell)
        XCTAssertTrue(cell is CityTableViewCell)        
    }
    
    func testTableView_dequeueReusableCell_IsCalled() {
        let city1 = City(name: "Prilep")
        let citiesStub = [city1]
        sut = CitiesPresenter(cities: citiesStub)
        let mockTableView = MockCitiesTableView()
        let cityCell = UINib(nibName: "CityCell", bundle: nil)
        mockTableView.register(cityCell, forCellReuseIdentifier: sut.cellIdentifier)
        mockTableView.dataSource = citiesVC
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(item: 0, section: 0))
        XCTAssertTrue(mockTableView.dequeueReusableCellisCalled)
    }
    
}
