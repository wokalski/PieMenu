//
//  RouletteTests.swift
//  RouletteTests
//
//  Created by Wojciech Czekalski on 20.11.2015.
//  Copyright © 2015 wczekalski. All rights reserved.
//

import XCTest

class GeometryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testZeroMeasurement() {
        let angle = Angle(a: CGPoint(x: 50, y: -40), b: CGPointZero, vertex: CGPointZero)
        XCTAssertEqual(0, angle.measure())
    }
    
    func testTestAngleInFirstQuadrant() {
        let angle =  Angle(a: CGPoint(x: cos(M_PI/6), y: sin(M_PI/6)), b: CGPoint(x: 10, y: 0), vertex: CGPointZero)
        XCTAssertEqualWithAccuracy(Double(angle.measure()), -M_PI/6, accuracy: 0.00001)
    }
    
}
