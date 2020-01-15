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
    
    // MARK: - Private properties
    private var sensors: Sensors!
    
    @IBAction func dismiss(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSensorTableView()
        presenter.delegate = self
        presenter.fetchSensors()        
    }
    
    private func configureSensorTableView() {
        sensorsTableView.dataSource = self
        sensorsTableView.delegate = self
        let sensorCell = UINib(nibName: "SensorCell", bundle: nil)
        sensorsTableView.register(sensorCell, forCellReuseIdentifier: presenter.cellIdentifier)
        sensorsTableView.delaysContentTouches = false
    }
}

extension SensorsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected sensor at \(indexPath.row)")
        presenter.tapOnSensor(sensor: sensors[indexPath.row])
    }
}

extension SensorsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard sensors != nil else { return 0 }
        return sensors.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: presenter.cellIdentifier, for: indexPath) as! SensorTableViewCell
        cell.delegate = self
        let sensor = sensors[indexPath.row]
        cell.configure(with: sensor)
        cell.setState(state: self.presenter.getSensorState(for: sensor))
        return cell
    }
}

extension SensorsViewController: SensorsView {
    
    func startLoading() {
        showLoader()
    }
    
    func finishLoading(with sensors: Sensors) {
        print(sensors)
        self.sensors = sensors
        self.sensorsTableView.reloadData()
        hideLoader()
    }
    
    func sensorStateSaved() {
        self.sensorsTableView.reloadData()
    }
    
    func errorFetching(error: Error) {
    }
    
    func showSensorDetails(sensor: Sensor) {
        coordinator?.showAverageDataViewController(for: sensor)
        print("Show sensor details for \(sensor)")
    }
}


extension SensorsViewController: SensorCellDelegate {
    func toggle(sensor: Sensor, with state: SensorState) {
        presenter.setSensorState(for: sensor, state: state)
    }
}
