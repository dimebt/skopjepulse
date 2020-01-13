//
//  GradientBackgroundUIView.swift
//  Best Soccer Tips
//
//  Created by Dimitar Stefanovski on 5/28/18.
//  Copyright © 2018 Dimitar Stefanovski. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: UIView {
    @IBInspectable var topColor: UIColor = UIColor.white
    @IBInspectable var bottomColor: UIColor = UIColor.black
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [topColor.cgColor, bottomColor.cgColor]
    }
        
    convenience init(topColor: UIColor, bottomColor: UIColor) {
        self.init(frame: CGRect.zero)
        self.topColor = topColor
        self.bottomColor = bottomColor        
    }
    
}

