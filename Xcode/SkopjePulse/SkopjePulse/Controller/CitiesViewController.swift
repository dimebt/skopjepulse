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
        presenter.delegate = self        
        configureCityTableView()
    }
    
    public func configureSearchBar() {
        searchBar.searchTextField.textColor = .white
    }
    
    private func configureCityTableView() {
        cityTableView.dataSource = self
        cityTableView.delegate = self
        let cityCell = UINib(nibName: "CityCell", bundle: nil)
        cityTableView.register(cityCell, forCellReuseIdentifier: presenter.cellIdentifier)
        cityTableView.delaysContentTouches = false
    }
}

extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.citiesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: presenter.cellIdentifier, for: indexPath) as! CityTableViewCell
        cell.configure(with: presenter.cities[indexPath.row])
        return cell
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

extension CitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.searchText = searchText
        print("Searching for city: \(searchText)")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension CitiesViewController: CitiesPresenterDelegate {
    func didFinishQuering() {
        print("Called search delega")
        self.cityTableView.reloadData()
    }
}
