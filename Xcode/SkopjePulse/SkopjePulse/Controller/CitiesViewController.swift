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
        
        //showLoader()
        
        configureCityTableView()
    }
    
    private func configureCityTableView() {
        cityTableView.dataSource = presenter.dataService
        cityTableView.delegate = self
        let cityCell = UINib(nibName: "CityCell", bundle: nil)
        cityTableView.register(cityCell, forCellReuseIdentifier: presenter.dataService.cellIdentifier)
        cityTableView.delaysContentTouches = false
    }
}

extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = presenter.dataService.cities[indexPath.row]
        coordinator?.showSensorsViewController(for: city)
        print("Selected \(city.name)")
    }
}
