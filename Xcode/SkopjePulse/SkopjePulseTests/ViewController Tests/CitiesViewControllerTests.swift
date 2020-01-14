//
//  CitiesViewControllerTests.swift
//  SkopjePulseTests
//
//  Created by Dimitar Stefanovski on 1/14/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import XCTest
@testable import SkopjePulse

class CitiesViewControllerTests: XCTestCase {
    
    var sut: CitiesViewController!
    var citiesPresenter: CitiesPresenter!
   
    override func setUp() {
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CitiesViewController") as? CitiesViewController
        citiesPresenter = CitiesPresenter()
        sut.presenter = citiesPresenter
        _ = sut.view
    }

    override func tearDown() {
        sut = nil
    }
    
    func testCitiesPresenter_shoudNotBeNil() {
        XCTAssertNotNil(citiesPresenter)
    }

    func testTableView_shoudNotBeNil() {
        XCTAssertNotNil(sut.cityTableView)
    }
    
    func testTableViewDataSource_On_viewDidLoad_SetsTableViewDataSource() {
        XCTAssertNotNil(sut.cityTableView.dataSource)
        XCTAssertTrue(sut.cityTableView.dataSource is CitiesDataService)
    }
    
    func testTableViewDelegate_On_viewDidLoad_SetsTableViewDelagate() {
        XCTAssertNotNil(sut.cityTableView.delegate)
        XCTAssertTrue(sut.cityTableView.delegate is CitiesViewController)
    }
    
    func testTableView_didSelectRowAt_isCalled() {
        sut.cityTableView.delegate?.tableView?(sut.cityTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        let selectedCity = sut.presenter.dataService.cities[0]
        XCTAssertNotNil(selectedCity)
        XCTAssertEqual(selectedCity.name, "Skopje")
    }
    
    func testMockTableView_didSelectRowAt_isCalled() {
        let mockTableView = MockCitiesTableView()
        mockTableView.delegate = sut
        _ = mockTableView.tableView(mockTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockTableView.tableViewdidSelectRowAtIsCalled)
    }
}
