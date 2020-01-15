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
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCityTableView()
    }
    
    public func configureSearchBar() {
        searchBar.searchTextField.textColor = .white
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

extension CitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.searchText = searchText
        print("Searching for city: \(searchText)")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
