//
//  MainCoordinator.swift
//  Coordinator Test
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
         let mainController = ViewController.instantiate()
         mainController.coordinator = self
         navigationController.pushViewController(mainController, animated: false)
    }
}
