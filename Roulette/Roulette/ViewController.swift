//
//  ViewController.swift
//  Roulette
//
//  Created by Wojciech Czekalski on 31.10.2015.
//  Copyright © 2015 wczekalski. All rights reserved.
//

import UIKit
import CoreGraphics

func rotated(angle: Double) {
    
}

class ViewController: UIViewController {
    
    let rotationController = RotationController(rotationCallback: rotated)
    
    override func viewDidLoad() {
        
        let view = UIView(frame: CGRect(x: 40, y: 40, width: 300, height: 300))
        view.backgroundColor = UIColor.greenColor()
        let arcss = arcs(CGPoint(x: 150, y: 150), radius: CGFloat(view.frame.inscribedCircleRadius()), numberOfSegments: 5)
        let laayers = layers(view.frame, arcs: arcss)
        
        for layer in laayers {
            
            view.layer.addSublayer(layer)
        }
        
        self.view?.addSubview(view)
        view.addGestureRecognizer(rotationController.gestureRecognizer)
    }
}

class RotationController {
    let gestureRecognizer = UIPanGestureRecognizer()
    let rotated: Double -> ()
    private var lastTouchTranslationFromCenter = Translation(x: 0, y: 0)
    
    init(rotationCallback: (Double) -> ()) {
        rotated = rotationCallback
        gestureRecognizer.addTarget(self, action: Selector("callback"))
        gestureRecognizer.maximumNumberOfTouches = 1
    }
    
    @objc func callback() {
        guard let view = gestureRecognizer.view else {
            return
        }
        
        let vertex = view.bounds.center()
        let point1 = vertex.translate(lastTouchTranslationFromCenter)
        let point2 = gestureRecognizer.locationInView(view)
        
        self.rotated(Double(angle(point1, vertex: vertex, point2: point2)))
        
        lastTouchTranslationFromCenter = vertex.translationFromPoint(point2)
    }
}

func angle(point1: CGPoint, vertex: CGPoint, point2: CGPoint) -> CGFloat {
    return 0
}

extension CGRect {
    func center() -> CGPoint {
        return CGPoint(x: CGRectGetMidX(self), y: CGRectGetMidY(self))
    }
}

extension CGPoint {
    
    func translationFromPoint(point: CGPoint) -> Translation {
        return Translation(x: self.x-point.x, y: self.y-point.y)
    }
    
    func translate(t: Translation) -> CGPoint {
        return CGPoint(x: self.x+t.x, y: self.y+t.y)
    }
}

struct Translation {
    let x: CGFloat
    let y: CGFloat
}
