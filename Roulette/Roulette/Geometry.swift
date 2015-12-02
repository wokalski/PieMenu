//
//  Geometry.swift
//  Roulette
//
//  Created by Wojciech Czekalski on 20.11.2015.
//  Copyright © 2015 wczekalski. All rights reserved.
//

import UIKit

struct Angle {
    let a: CGPoint
    let b: CGPoint
    let vertex: CGPoint
    
    // In radians
    func measure() -> CGFloat {
        guard a != vertex && b != vertex else {
            return 0
        }
        
        let f = { (x: CGPoint) in atan2(x.y - self.vertex.y, x.x - self.vertex.x) }
        return f(b) - f(a)
    }
}

extension CGRect {
    func center() -> CGPoint {
        return CGPoint(x: CGRectGetMidX(self), y: CGRectGetMidY(self))
    }
}

typealias Translation = CGPoint

extension CGPoint {
    
    func translationFromPoint(point: CGPoint) -> Translation {
        return Translation(x: self.x-point.x, y: self.y-point.y)
    }
    
    func translate(t: Translation) -> CGPoint {
        return CGPoint(x: self.x+t.x, y: self.y+t.y)
    }
}

extension CGPoint {
    func scale(a: CGFloat) -> CGPoint {
        return CGPoint(x: self.x*a, y: self.y*a)
    }
}

extension CGRect {
    func inscribedCircleRadius() -> CGFloat {
        return self.size.height/2
    }
}