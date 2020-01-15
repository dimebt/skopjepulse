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
    
    private var searchService: SearchService!
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
         searchService: SearchService = SearchService()) {
        self.cities = cities
        self.searchService = searchService
        
        //  MARK: - Setting the subscriber on the publisher $searchText
        searchTextSubscriber = $searchText
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .removeDuplicates().sink(receiveValue: { (term) in
                guard !term.isEmpty else { return }
                searchService.search(term: term, cities: cities)
                self.cities = searchService.queryResults
                self.delegate?.didFinishQuering()
            })
        
    }
    
    
}
