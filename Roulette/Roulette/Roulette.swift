//
//  Roulette.swift
//  Roulette
//
//  Created by Wojciech Czekalski on 17.11.2015.
//  Copyright © 2015 wczekalski. All rights reserved.
//

import UIKit

func radians(degrees: Double) -> Double {
    return degrees * M_PI/180
}

extension CGRect {
    func inscribedCircleRadius() -> Double {
        return Double(self.size.height/2)
    }
}

struct Roulette {
    let numberOfSegments: Int
}

func anglesForArc(numberOfSegments: Int, segmentIndex: Int) -> (startAngle: CGFloat, endAngle: CGFloat) {
    let segmentHalfAngle = M_PI*2/Double(numberOfSegments)/2
    let centerAngle = radians(360/Double(numberOfSegments)*Double(segmentIndex)) - M_PI_2
    
    return (CGFloat(centerAngle - segmentHalfAngle), CGFloat(centerAngle + segmentHalfAngle))
}

func arcs(center: CGPoint, radius: CGFloat, numberOfSegments: Int) -> [UIBezierPath] {
    
    return [Int](0..<numberOfSegments).map { i in
        
        let angles = anglesForArc(numberOfSegments, segmentIndex: i)
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: angles.startAngle, endAngle: angles.endAngle, clockwise: true)
        
        let beginningPoint = CGPoint(x: cos(angles.endAngle)*(radius-40)+radius, y: sin(angles.endAngle)*(radius-40)+radius)
        
        path.addLineToPoint(beginningPoint)
        path.addArcWithCenter(center, radius: radius-40, startAngle: angles.endAngle, endAngle: angles.startAngle, clockwise: false)
        
        let endPoint2 = CGPoint(x: cos(angles.startAngle)*radius+radius, y: sin(angles.startAngle)*radius+radius)
        
        path.addLineToPoint(endPoint2)
        
        return path
    }
}

func layers(frame: CGRect, arcs: [UIBezierPath]) -> [CAShapeLayer] {
    return arcs.map { path in
        let layer = CAShapeLayer()
        layer.frame = frame
        layer.path = path.CGPath
        layer.strokeColor = UIColor.blackColor().CGColor
        layer.fillColor = UIColor(hue: CGFloat(Float(rand()%1000)/Float(1000)), saturation: CGFloat(Float(rand()%1000)/Float(1000)), brightness: CGFloat(Float(rand()%1000)/Float(1000)), alpha: CGFloat(Float(rand()%1000)/Float(1000))).CGColor
        return layer
    }
}
