//
//  UIViewExtensions.swift
//  SplashLogin
//
//  Created by Lynn on 8/3/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 2.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 5.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate as? CAAnimationDelegate
        }
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue.init(cgPoint: CGPoint(x:center.x - 10, y:center.y))
        animation.toValue = NSValue.init(cgPoint: CGPoint(x:center.x + 10, y:center.y))
        layer.add(animation, forKey: "position")
    }
}

