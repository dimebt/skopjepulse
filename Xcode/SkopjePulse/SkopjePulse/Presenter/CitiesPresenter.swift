//
//  CitiesViewModel.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/13/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import UIKit
import Combine

protocol CitiesPresenterDelegate: class{
    func didFinishQuering()
}

class CitiesPresenter {
    
    private var searchService: CitySearchService!
    public var cities: [City]!
    public var cellIdentifier = "cityCell"
    weak var delegate: CitiesPresenterDelegate?
    
    //  MARK: - Publisher (It publishes values over time, specificly this is the text from the UISearchBar)
    @Published public var searchText: String = ""
    
    //  MARK: - Subscriber
    public var searchTextSubscriber: AnyCancellable?
    
    public var citiesCount: Int {
        guard self.cities != nil else { return 0 }
        return self.cities.count
    }
    
    init(cities: [City] = PulseEco.cities,
         searchService: CitySearchService = CitySearchService()) {
        self.cities = cities
        self.searchService = searchService
        
        //  MARK: - Setting the subscriber on the publisher $searchText
        //  Searching for the city in the [City] array with keyboard tapping debounce and removeing duplicate entries
        searchTextSubscriber = $searchText
            .debounce(for: 0.4, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { (term) in
                searchService.search(term: term, bag: cities)
                self.cities = searchService.queryResults
                self.delegate?.didFinishQuering()
            })
        
    }
    
    
}
