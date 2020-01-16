//
//  LoadingViewController.swift
//  SMS Commands
//
//  Created by Dimitar Stefanovski on 11/28/19.
//  Copyright © 2019 Dimitar Stefanovski. All rights reserved.
//

import UIKit
import Lottie

class LoadingViewController: UIViewController, Storyboarded {
   
    var lottieAnimation = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLottie()
    }
    
    private func setupLottie() {
        lottieAnimation = AnimationView(name: "927-triangle-loading")
        lottieAnimation.backgroundBehavior = .pauseAndRestore
        lottieAnimation.play()
        lottieAnimation.loopMode = .loop
        self.view.addSubview(lottieAnimation)
        lottieAnimation.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = lottieAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = lottieAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = lottieAnimation.widthAnchor.constraint(equalToConstant: self.view.frame.height * 0.25)
        let heightConstraint = lottieAnimation.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.25)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
}
