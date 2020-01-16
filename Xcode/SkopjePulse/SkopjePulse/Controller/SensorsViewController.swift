//
//  SensorsViewController.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/13/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class SensorsViewController: UIViewController, Storyboarded {    
    
    public var presenter: SensorsPresenter!    
    weak var coordinator: MainCoordinator?
    @IBOutlet weak var sensorsTableView: UITableView!
    @IBOutlet weak var searchBar: PulseUISearchBar!
    @IBOutlet weak var noRecords1: UILabel!
    @IBOutlet weak var noRecords2: UILabel!
    
    @IBAction func dismiss(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.fetchSensors()
        configureSensorTableView()
    }
    
    private func configureSensorTableView() {
        sensorsTableView.dataSource = self
        sensorsTableView.delegate = self
        let sensorCell = UINib(nibName: "SensorCell", bundle: nil)
        sensorsTableView.register(sensorCell, forCellReuseIdentifier: presenter.cellIdentifier)
        sensorsTableView.delaysContentTouches = false
    }
    
    //  MARK: - Dismiss the keyboard when tap on view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
}

extension SensorsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        presenter.canTap(on: presenter.sensors[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

extension SensorsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard presenter.sensors != nil else { return 0 }
        if presenter.sensors.count == 0 {
            self.noRecords1.isHidden = false
            self.noRecords2.isHidden = false
        } else {
            self.noRecords1.isHidden = true
            self.noRecords2.isHidden = true
        }
        return presenter.sensors.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: presenter.cellIdentifier, for: indexPath) as! SensorTableViewCell
        cell.delegate = self
        let sensor = presenter.sensors[indexPath.row]
        cell.configure(with: sensor)
        cell.configureState(state: presenter.getState(for: sensor))
        return cell
    }
}

extension SensorsViewController: SensorsPresenterDelegate {
    func startLoading() {
        showLoader()
    }
    
    func finishLoading() {
        self.sensorsTableView.reloadData()
        hideLoader()
    }
    
    func sensorStateChanged() {
        sensorsTableView.reloadData()
    }
    
    func errorFetching(error: Error) {
    }
    
    func showSensorDetails(city: City, sensor: Sensor, sensorData: SensorData) {
        coordinator?.showAverageDataViewController(for: city, sensor: sensor, sensorData: sensorData)
    }
    func didFinishQuering() {
        sensorsTableView.reloadData()
    }
}

extension SensorsViewController: SensorCellDelegate {
    func toggle(sensor: Sensor, with state: SensorState) {
        presenter.toggle(sensor: sensor, state: state)
    }
}


extension SensorsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchText = searchText
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
