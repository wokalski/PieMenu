//
//  Interation.swift
//  Roulette
//
//  Created by Wojciech Czekalski on 19.11.2015.
//  Copyright © 2015 wczekalski. All rights reserved.
//

import UIKit

struct Angle {
    let a: CGPoint
    let b: CGPoint
    let vertex: CGPoint
    
    // In radians
    func measure() -> CGFloat {
        let f = { (x: CGPoint) in atan2(x.y - self.vertex.y, x.x - self.vertex.x) }
        return f(a) - f(b)
    }
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

typealias Translation = CGPoint