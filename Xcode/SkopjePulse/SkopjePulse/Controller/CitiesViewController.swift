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
    @IBOutlet weak var searchBar: PulseUISearchBar!
    @IBOutlet weak var noRecordLabel1: UILabel!
    @IBOutlet weak var noRecordLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self        
        configureCityTableView()        
    }
    
    private func configureCityTableView() {
        cityTableView.dataSource = self
        cityTableView.delegate = self
        let cityCell = UINib(nibName: "CityCell", bundle: nil)
        cityTableView.register(cityCell, forCellReuseIdentifier: presenter.cellIdentifier)
        cityTableView.delaysContentTouches = false
    }
    
    //  MARK: - Dismiss the keyboard when tap on view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
}

extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presenter.citiesCount == 0 {
            noRecordLabel1.isHidden = false
            noRecordLabel2.isHidden = false
        } else {
            noRecordLabel1.isHidden = true
            noRecordLabel2.isHidden = true
        }
        return presenter.citiesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: presenter.cellIdentifier, for: indexPath) as! CityTableViewCell
        cell.configure(with: presenter.cities[indexPath.row])
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = presenter.cities[indexPath.row]
        self.view.endEditing(true)
        coordinator?.showSensorsViewController(for: city)
    }
}

extension CitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.searchText = searchText
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension CitiesViewController: CitiesPresenterDelegate {
    func didFinishQuering() {
        self.cityTableView.reloadData()
    }
}
