//
//  ViewController.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/12/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController, Storyboarded {

    public var presenter: CitiesPresenter!
    weak var coordinator: MainCoordinator?
    @IBOutlet weak var cityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCityTableView()
        
        
        
        let sensorsEndpointBitola = EndpointFactory.create(for: .Bitola, endpoint: .Sensors)!
        //let sensorData24h = EndpointFactory.create(for: .Skopje, endpoint: .Data24h)!
        let fetcher = NetworkFetcher<Sensors>()
        fetcher.fetch(from: sensorsEndpointBitola) { result in
            print(result)
        }
//        LocalJsonFetcher<Sensors>().fetch(from: URL(string: "restSensorsBitola")!) { (result) in
//            print(result)
//        }
        
    }
    
    private func configureCityTableView() {
        cityTableView.dataSource = presenter
        let cityCell = UINib(nibName: "CityCell", bundle: nil)
        cityTableView.register(cityCell, forCellReuseIdentifier: presenter.cellIdentifier)
        cityTableView.delaysContentTouches = false
    }
}

extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = presenter.cities[indexPath.row]
        coordinator?.showSensorsViewController(for: city)
    }
}
