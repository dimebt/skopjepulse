//
//  SomethingWentWrongViewController.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/16/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import UIKit
import Lottie

class SomethingWentWrongViewController: UIViewController, Storyboarded {

    weak var coordinator: MainCoordinator?
    
  var lottieAnimation = AnimationView()
    @IBAction func dismiss(_ sender: Any) {
        coordinator?.start()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLottie()
    }
    
    private func setupLottie() {
        lottieAnimation = AnimationView(name: "3146-404page")
        lottieAnimation.backgroundBehavior = .pauseAndRestore
        lottieAnimation.play()
        lottieAnimation.loopMode = .loop
        self.view.addSubview(lottieAnimation)
        lottieAnimation.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = lottieAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = lottieAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = lottieAnimation.widthAnchor.constraint(equalToConstant: self.view.frame.height * 0.6)
        let heightConstraint = lottieAnimation.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.6)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }

}
