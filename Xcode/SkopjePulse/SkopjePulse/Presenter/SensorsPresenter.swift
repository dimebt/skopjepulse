//
//  SensorsViewModel.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/13/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class SensorsPresenter: NSObject {
    var sensors: Sensors!
    var city: City!
    var cellIdentifier = "sensorCell"
    var fetchService: NetworkFetcher<Sensors>!
    
    init(fetchService: NetworkFetcher<Sensors> = NetworkFetcher<Sensors>(), city: City) {
        self.fetchService = fetchService
        self.city = city
    }
}

extension SensorsPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard sensors != nil else { return 0 }
        return sensors.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SensorTableViewCell
        cell.configure(with: sensors[indexPath.row])
        return cell
    }
}
