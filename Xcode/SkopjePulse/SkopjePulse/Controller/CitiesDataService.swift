//
//  CitiesDataService.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/14/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class CitiesDataService: NSObject, UITableViewDataSource {
    
    public var cities: [City]!
    public var cellIdentifier = "cityCell"    
    
    init(cities: [City]) {
        self.cities = cities
    }
    
    public var citiesCount: Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CityTableViewCell
        cell.configure(with: cities[indexPath.row])
        return cell
    }
}
