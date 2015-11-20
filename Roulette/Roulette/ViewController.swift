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
    
    override func viewDidLoad() {
        
        let r = RouletteGeometry(frame: CGRect(x: 50, y: 50, width: 300, height: 300), width: 60)
        
        let layers = [Int](0..<4).map { i in
            return Segment(numberOfSegments: 4, segmentIndex: i)
        }.map { s in
            return segment(r, segment: s)
        }.map { (path: UIBezierPath) -> CAShapeLayer in
            let s = path.shapeLayer()
            s.frame = r.bounds
            s.fillColor = UIColor.greenColor().CGColor
            s.strokeColor = UIColor.blackColor().CGColor
            return s
        }
        
        for l in layers {
            self.view.layer.addSublayer(l)
        }
    }
}

