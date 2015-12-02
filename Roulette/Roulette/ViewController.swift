//
//  ViewController.swift
//  Roulette
//
//  Created by Wojciech Czekalski on 31.10.2015.
//  Copyright © 2015 wczekalski. All rights reserved.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController {
    
    let gestureRecognizer = UIPanGestureRecognizer()
    let rouletteView = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: 300, height: 300)))
    var lastTranslationFromCenter: CGPoint = CGPointZero
    
    override func viewDidLoad() {
        
        let r = RouletteGeometry(frame: CGRect(x: 0, y: 0, width: 300, height: 300), width: 60)
        
        let layers = r.donut().split(4).map { s in
            return s.bezierPath().shapeLayer()
        }

        for l in layers {
            l.frame = r.bounds
            l.strokeColor = UIColor.blackColor().CGColor
            l.fillColor = UIColor.clearColor().CGColor
            rouletteView.layer.addSublayer(l)
        }
        
        gestureRecognizer.addTarget(self, action: "rotated")
        gestureRecognizer.maximumNumberOfTouches = 1
        
        rouletteView.layer.borderWidth = 1
        
        rouletteView.addGestureRecognizer(gestureRecognizer)
        self.view.addSubview(rouletteView)
        
    }
    
    @objc func rotated() {
        
        guard gestureRecognizer.state != .Ended else {
            lastTranslationFromCenter = CGPointZero
            return
        }
        
        let point = gestureRecognizer.locationInView(rouletteView)
        let center = rouletteView.bounds.center()
        let previousTouchPoint = center.translate(lastTranslationFromCenter)
        let angle = Angle(a: previousTouchPoint, b: point, vertex: center)
        
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        for l in rouletteView.layer.sublayers! {
            l.transform = CATransform3DRotate(l.transform, angle.measure(), 0, 0, 1)
        }
        CATransaction.commit()
        
        lastTranslationFromCenter = point.translationFromPoint(center)
    }
}

