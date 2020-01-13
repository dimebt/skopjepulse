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
    private var fetchService: NetworkFetcher<Sensors>!
    
    init(fetchService: NetworkFetcher<Sensors> = NetworkFetcher<Sensors>(), city: City) {
        self.fetchService = fetchService
        self.city = city
    }
    
    func fetch() {
        let endpoint = EndpointFactory.create(for: .Bitola, endpoint: .Sensors)!
        self.fetchService.fetch(from: endpoint) { (result) in
            switch result {
            case .success(let sensors):
                print(sensors)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SensorsPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SensorTableViewCell
        return cell
    }
}
