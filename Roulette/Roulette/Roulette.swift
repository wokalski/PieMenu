//
//  Roulette.swift
//  Roulette
//
//  Created by Wojciech Czekalski on 17.11.2015.
//  Copyright © 2015 wczekalski. All rights reserved.
//

import UIKit

extension CGRect {
    func inscribedCircleRadius() -> CGFloat {
        return self.size.height/2
    }
}

struct Roulette {
    let numberOfSegments: Int
}

struct RouletteGeometry {
    let frame: CGRect
    let width: CGFloat
    var bounds: CGRect {
        get {
            return CGRect(origin: CGPointZero, size: frame.size)
        }
    }
    var innerCircleFrame: CGRect {
        get {
            return CGRectInset(frame, width, width)
        }
    }
}

struct Segment {
    let startAngle: CGFloat
    let endAngle: CGFloat
}

extension Segment {
    init(numberOfSegments: Int, segmentIndex: Int) {
        
        let segmentAngle = M_PI*2/Double(numberOfSegments)
        let firstSegmentAngle = segmentAngle/2-M_PI_2
        let startAngle = firstSegmentAngle + segmentAngle*Double(segmentIndex)
        
        self.startAngle = CGFloat(startAngle)
        self.endAngle = CGFloat(startAngle+segmentAngle)
    }
    
    func inverse() -> Segment {
        return Segment(startAngle: endAngle, endAngle: startAngle)
    }
    
    // On the unit circle
    func coordinates() -> (start: CGPoint, end: CGPoint) {
        let f = { (x: CGFloat) in CGPoint(x: cos(x), y: sin(x)) }
        return (f(startAngle), f(endAngle))
    }
}

extension CGPoint {
    func scale(a: CGFloat) -> CGPoint {
        return CGPoint(x: self.x*a, y: self.y*a)
    }
}

extension UIBezierPath {
    func addArc(segment: Segment, circleFrame: CGRect, clockwise: Bool) {
        self.addArcWithCenter(circleFrame.center(), radius: circleFrame.inscribedCircleRadius(), startAngle: segment.startAngle, endAngle: segment.endAngle, clockwise: clockwise)
    }
}

typealias Coordinates = (start: CGPoint, end: CGPoint)

func segment(roulette: RouletteGeometry, segment: Segment) -> UIBezierPath {
    
    let s = roulette.frame.inscribedCircleRadius()
    let t = Translation(x: CGRectGetMidX(roulette.frame), y: CGRectGetMidX(roulette.frame))
    
    let f: Coordinates -> Coordinates = { c in (c.start.scale(s).translate(t), c.end.scale(s).translate(t)) }
    
    let coordinates = f(segment.inverse().coordinates())
    
    let path = UIBezierPath()
    path.addArc(segment, circleFrame: roulette.frame, clockwise: true)
    path.addLineToPoint(coordinates.start)
    path.addArc(segment.inverse(), circleFrame: roulette.innerCircleFrame, clockwise: false)
    path.addLineToPoint(coordinates.end)
    
    return path
}

extension UIBezierPath {
    
    func shapeLayer() -> CAShapeLayer {
        let l = CAShapeLayer()
        l.path = self.CGPath
        return l
    }
}
