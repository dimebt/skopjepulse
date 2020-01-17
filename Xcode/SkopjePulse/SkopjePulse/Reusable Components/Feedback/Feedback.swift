//
//  Feedback.swift
//  SkopjePulse
//
//  Created by Dimitar Stefanovski on 1/16/20.
//  Copyright © 2020 Dimitar Stefanovski. All rights reserved.
//

import UIKit

class Feedback {
    static let shared = Feedback()
    var generator: UIImpactFeedbackGenerator!
    
    private init () { }
    
    public func execute(
        with style: UIImpactFeedbackGenerator.FeedbackStyle = UIImpactFeedbackGenerator.FeedbackStyle.medium,
        generator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)) {
        self.generator = generator
        generator.impactOccurred()
    }
    
}


