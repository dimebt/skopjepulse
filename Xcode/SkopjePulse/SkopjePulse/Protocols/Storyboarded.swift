//
//  Storyboarded.swift
//  Coordinator Test
//
//  Created by Dimitar Stefanovski on 1/12/20.
//  Copyright © 2019 Dimitar Stefanovski. All rights reserved.
//

import UIKit

protocol Storyboarded { }

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let storyboardIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self 
    }
}
