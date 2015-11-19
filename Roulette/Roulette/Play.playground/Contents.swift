//: Playground - noun: a place where people can play

import UIKit
import CoreGraphics

let view = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 600))
view.backgroundColor = UIColor.whiteColor()
let arcss = arcs(CGPoint(x: 300, y: 300), radius: CGFloat(view.frame.inscribedCircleRadius()), numberOfSegments: 5)
let laayers = layers(view.frame, arcs: arcss)

for layer in laayers {
    
    view.layer.addSublayer(layer)
}

view

