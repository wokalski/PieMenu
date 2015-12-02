//
//  Roulette.swift
//  Roulette
//
//  Created by Wojciech Czekalski on 17.11.2015.
//  Copyright © 2015 wczekalski. All rights reserved.
//

import UIKit

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

struct Circle {
    let radius: CGFloat
    let center: CGPoint
    
    func split(n: UInt) -> [Arc] {
        return [UInt](0..<n).map { i in
            
            let segmentAngle = M_PI*2/Double(n)
            let firstSegmentAngle = segmentAngle/2-M_PI_2
            let startAngle = firstSegmentAngle + segmentAngle*Double(i)
            let endAngle = startAngle+segmentAngle
            
            return Arc(center: center, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
        }
    }
}

struct Arc {
    let center: CGPoint
    let radius: CGFloat
    let startAngle: CGFloat
    let endAngle: CGFloat
    let clockwise: Bool
    
    func startPoint() -> CGPoint {
        let f = { (x: CGFloat) in CGPoint(x: cos(x), y: sin(x)) }
        return f(startAngle).scale(radius).translate(center)
    }
    
    func endPoint() -> CGPoint {
        let f = { (x: CGFloat) in CGPoint(x: cos(x), y: sin(x)) }
        return f(endAngle).scale(radius).translate(center)
    }
    
    func inverse() -> Arc {
        return Arc(center: center, radius: radius, startAngle: endAngle, endAngle: startAngle, clockwise: !clockwise)
    }
}

// Represents a donut shape. Coming up with a better name would be appreciated
struct DonutShape {
    let outerCircle: Circle
    let innerCircle: Circle
}

struct DonutSlice {
    let outerArc: Arc
    let innerArc: Arc
}

extension RouletteGeometry {
    func donut() -> DonutShape {
        return DonutShape(outerCircle: Circle(rect: (frame)), innerCircle: Circle(rect: innerCircleFrame))
    }
}


extension Circle {
    init(rect: CGRect) {
        self.radius = rect.inscribedCircleRadius()
        self.center = rect.center()
    }
}

extension DonutShape {
    
    static func segment(a: Arc, b: Arc) -> DonutSlice {
        return DonutSlice(outerArc: a, innerArc: b)
    }
    
    func split(n: UInt) -> [DonutSlice] {
        return zip(outerCircle.split(n), innerCircle.split(n)).map(DonutShape.segment)
    }
}

extension DonutSlice {
    func bezierPath() -> UIBezierPath {
        
        let i = innerArc.inverse()
        
        let path = UIBezierPath()
        path.addArc(outerArc)
        path.addLineToPoint(i.startPoint())
        path.addArc(i)
        path.addLineToPoint(outerArc.startPoint())
        return path
    }
}

extension UIBezierPath {
    func addArc(a: Arc) {
        self.addArcWithCenter(a.center, radius: a.radius, startAngle: a.startAngle, endAngle: a.endAngle, clockwise: a.clockwise)
    }

    func shapeLayer() -> CAShapeLayer {
        let l = CAShapeLayer()
        l.path = self.CGPath
        return l
    }
}
