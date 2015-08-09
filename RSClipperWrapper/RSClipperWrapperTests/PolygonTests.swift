//
//  PolygonTests.swift
//  RSClipperWrapper
//
//  Created by Matthias Fey on 09.08.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

import XCTest
import RSClipperWrapper

class PolygonTests: XCTestCase {

    func testPolygon() {
        var polygon = Polygon()
        XCTAssert(polygon.isEmpty)
        XCTAssertEqual(polygon.count, 0)
        XCTAssertEqual(polygon.area, 0)
        XCTAssertEqual(polygon.description, "[]")
        
        polygon.append(CGPoint(x: 0, y: 0))
        XCTAssertFalse(polygon.isEmpty)
        XCTAssertEqual(polygon.count, 1)
        XCTAssertEqual(polygon[0], CGPoint(x: 0, y: 0))
        XCTAssertEqual(polygon.area, 0)
        XCTAssertEqual(polygon.description, "[(0.0, 0.0)]")
        
        polygon.append(CGPoint(x: 0, y: 1))
        XCTAssertFalse(polygon.isEmpty)
        XCTAssertEqual(polygon.count, 2)
        XCTAssertEqual(polygon[1], CGPoint(x: 0, y: 1))
        XCTAssertEqual(polygon.area, 0)
        XCTAssertEqual(polygon.description, "[(0.0, 0.0), (0.0, 1.0)]")
        
        polygon.append(CGPoint(x: 1, y: 1))
        polygon.append(CGPoint(x: 1, y: 0))
        XCTAssertFalse(polygon.isEmpty)
        XCTAssertEqual(polygon.count, 4)
        XCTAssertEqual(polygon[2], CGPoint(x: 1, y: 1))
        XCTAssertEqual(polygon[3], CGPoint(x: 1, y: 0))
        XCTAssertEqual(polygon.area, 1)
        XCTAssertEqual(polygon.description, "[(0.0, 0.0), (0.0, 1.0), (1.0, 1.0), (1.0, 0.0)]")
        
        polygon.removeAtIndex(2)
        polygon.insert(CGPoint(x: 2, y: 1), atIndex: 2)
        XCTAssertEqual(polygon[2], CGPoint(x: 2, y: 1))
        polygon.removeLast()
        polygon.insert(CGPoint(x: 2, y: 0), atIndex: 3)
        XCTAssertEqual(polygon[3], CGPoint(x: 2, y: 0))
        XCTAssertFalse(polygon.isEmpty)
        XCTAssertEqual(polygon.count, 4)
        XCTAssertEqual(polygon.area, 2)
        
        polygon[2] = CGPoint(x: 3, y: 1)
        polygon[3] = CGPoint(x: 3, y: 0)
        XCTAssertEqual(polygon[2], CGPoint(x: 3, y: 1))
        XCTAssertEqual(polygon[3], CGPoint(x: 3, y: 0))
        XCTAssertFalse(polygon.isEmpty)
        XCTAssertEqual(polygon.count, 4)
        XCTAssertEqual(polygon.area, 3)
        
        for (index, point) in polygon.enumerate() {
            XCTAssertLessThan(index, polygon.count)
            XCTAssertLessThanOrEqual(point.x, 3)
            XCTAssertLessThanOrEqual(point.y, 1)
        }
        
        polygon.removeAll()
        XCTAssert(polygon.isEmpty)
        XCTAssertEqual(polygon.count, 0)
        
        polygon = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 0.5)]
        XCTAssertFalse(polygon.isEmpty)
        XCTAssertEqual(polygon.count, 3)
        XCTAssertEqual(polygon.area, 0.5)
        
        polygon = Polygon([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 0.5)])
        XCTAssertFalse(polygon.isEmpty)
        XCTAssertEqual(polygon.count, 3)
        XCTAssertEqual(polygon.area, 0.5)
    }
}
