//
//  ViewController.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/12/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {

    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sensorsEndpoint = EndpointFactory.create(for: .Bitola, endpoint: .Sensors)!
        let sensorData24h = EndpointFactory.create(for: .Skopje, endpoint: .Data24h)!
        
        let fetcher = NetworkFetcher<SensorData>()
        fetcher.fetch(from: sensorData24h) { result in
            print(result)
        }
    }
}
