//
//  Coordinator.swift
//  Coordinator Test
//
//  Created by Dimitar Stefanovski on 1/12/20.
//  Copyright © 2019 Dimitar Stefanovski. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var children: [Coordinator] { get set }
    func start()
}
