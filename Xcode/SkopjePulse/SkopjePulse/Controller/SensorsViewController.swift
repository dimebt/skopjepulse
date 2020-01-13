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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSensorTableView()
    }
    
    private func configureSensorTableView() {
        sensorsTableView.dataSource = presenter
        let sensorCell = UINib(nibName: "SensorCell", bundle: nil)
        sensorsTableView.register(sensorCell, forCellReuseIdentifier: presenter.cellIdentifier)
        sensorsTableView.delaysContentTouches = false
    }
}

extension SensorsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
