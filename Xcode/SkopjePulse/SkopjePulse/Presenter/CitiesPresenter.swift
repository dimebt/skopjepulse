//
//  CitiesViewModel.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/13/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class CitiesPresenter: NSObject {
    
    public var dataService: CitiesDataService!    
    
    init(dataService: CitiesDataService = CitiesDataService(cities: PulseEco.cities)) {        
        self.dataService = dataService
    }
}
