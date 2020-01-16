//
//  MainCoordinator.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 10/4/19.
//  Copyright © 2019 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var children = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainController = CitiesViewController.instantiate()
        let presenter = CitiesPresenter()
        mainController.coordinator = self
        mainController.presenter = presenter
        navigationController.pushViewController(mainController, animated: false)
    }
    
    func showSensorsViewController(for city: City) {        
        let presenter = SensorsPresenter(city: city)
        let sensorsViewController = SensorsViewController.instantiate()
        sensorsViewController.presenter = presenter
        sensorsViewController.coordinator = self
        navigationController.pushViewController(sensorsViewController, animated: false)
    }
    
    func showAverageDataViewController(for city: City, sensor: Sensor, sensorData: SensorData) {
        let presenter = AverageDataPresenter(city: city, sensor: sensor, sensorData: sensorData)
        let averageDataViewController = AverageDataViewController.instantiate()
        averageDataViewController.presenter = presenter
        averageDataViewController.coordinator = self
        navigationController.pushViewController(averageDataViewController, animated: true)
    }
    
    func showloader() {
        let loadingViewController = LoadingViewController.instantiate()
        navigationController.pushViewController(loadingViewController, animated: false)
    }
    
    func hideLoader() {
        if let _ = navigationController.topViewController as? LoadingViewController {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.navigationController.popViewController(animated: false)
            }
        }
    }
}
