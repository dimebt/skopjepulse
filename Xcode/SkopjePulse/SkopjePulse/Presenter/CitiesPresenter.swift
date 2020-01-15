//
//  CitiesViewModel.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/13/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import UIKit
import Combine

class CitiesPresenter: NSObject {
      
    public var dataService: CitiesDataService!
    @Published public var searchText: String = ""
    public var searchTextPublisher: AnyPublisher<String, Never> {
        return $searchText
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .removeDuplicates()
            .print()
            .eraseToAnyPublisher()
    }
    
    public var searchTextSubscriber: AnyCancellable?
    
    init(dataService: CitiesDataService = CitiesDataService(cities: PulseEco.cities)) {
        super.init()
        self.dataService = dataService
        searchTextSubscriber = searchTextPublisher.sink(receiveValue: { (value) in
            print(value)
        })
    }
}
