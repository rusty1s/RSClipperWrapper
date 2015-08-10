//
//  ClipperTests.swift
//  RSClipperWrapper
//
//  Created by Matthias Fey on 09.08.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

import XCTest
import RSClipperWrapper

class ClipperTests: XCTestCase {

    func testUnion() {
        var polygon1: Polygon = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 0)]
        var polygon2: Polygon = [CGPoint(x: 0.5, y: 0.5), CGPoint(x: 0.5, y: 1.5), CGPoint(x: 1.5, y: 1.5), CGPoint(x: 1.5, y: 0.5)]
        
        var polygons = Clipper.unionPolygon(polygon1, withPolygon: polygon2)
        XCTAssertFalse(polygons.isEmpty)
        XCTAssertEqual(polygons.count, 1)
        
        let unionPolygon = polygons.first!
        XCTAssertFalse(unionPolygon.isEmpty)
        XCTAssertEqual(unionPolygon.count, 8)
        XCTAssert(unionPolygon.contains(CGPoint(x: 0, y: 0)))
        XCTAssert(unionPolygon.contains(CGPoint(x: 0, y: 1)))
        XCTAssert(unionPolygon.contains(CGPoint(x: 0.5, y: 1)))
        XCTAssert(unionPolygon.contains(CGPoint(x: 0.5, y: 1.5)))
        XCTAssert(unionPolygon.contains(CGPoint(x: 1.5, y: 1.5)))
        XCTAssert(unionPolygon.contains(CGPoint(x: 1.5, y: 0.5)))
        XCTAssert(unionPolygon.contains(CGPoint(x: 1, y: 0.5)))
        XCTAssert(unionPolygon.contains(CGPoint(x: 1, y: 0)))
        
        polygon1 = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 0)]
        polygon2 = [CGPoint(x: 2, y: 2), CGPoint(x: 2, y: 3), CGPoint(x: 3, y: 3), CGPoint(x: 3, y: 2)]
        
        polygons = Clipper.unionPolygon(polygon1, withPolygon: polygon2)
        XCTAssertFalse(polygons.isEmpty)
        XCTAssertEqual(polygons.count, 2)
        XCTAssertFalse(polygons.first!.isEmpty)
        XCTAssertEqual(polygons.first!.count, 4)
        XCTAssertFalse(polygons.last!.isEmpty)
        XCTAssertEqual(polygons.last!.count, 4)
    }
    
    func testDifference() {
        var polygon1: Polygon = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 0)]
        var polygon2: Polygon = [CGPoint(x: 0.5, y: 0.5), CGPoint(x: 0.5, y: 1.5), CGPoint(x: 1.5, y: 1.5), CGPoint(x: 1.5, y: 0.5)]
        
        var polygons = Clipper.differencePolygon(polygon1, fromPolygon: polygon2)
        XCTAssertFalse(polygons.isEmpty)
        XCTAssertEqual(polygons.count, 1)
        
        let differencePolygon = polygons.first!
        XCTAssertFalse(differencePolygon.isEmpty)
        XCTAssertEqual(differencePolygon.count, 6)
        XCTAssert(differencePolygon.contains(CGPoint(x: 0, y: 0)))
        XCTAssert(differencePolygon.contains(CGPoint(x: 0, y: 1)))
        XCTAssert(differencePolygon.contains(CGPoint(x: 0.5, y: 1)))
        XCTAssert(differencePolygon.contains(CGPoint(x: 0.5, y: 0.5)))
        XCTAssert(differencePolygon.contains(CGPoint(x: 1, y: 0.5)))
        XCTAssert(differencePolygon.contains(CGPoint(x: 1, y: 0)))
        
        polygon1 = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 0)]
        polygon2 = [CGPoint(x: 2, y: 2), CGPoint(x: 2, y: 3), CGPoint(x: 3, y: 3), CGPoint(x: 3, y: 2)]
        
        polygons = Clipper.differencePolygon(polygon1, fromPolygon: polygon2)
        XCTAssertFalse(polygons.isEmpty)
        XCTAssertEqual(polygons.count, 1)
        XCTAssertFalse(polygons.first!.isEmpty)
        XCTAssertEqual(polygons.first!.count, 4)
        XCTAssert(polygons.first!.contains(CGPoint(x: 0, y: 0)))
        XCTAssert(polygons.first!.contains(CGPoint(x: 0, y: 1)))
        XCTAssert(polygons.first!.contains(CGPoint(x: 1, y: 1)))
        XCTAssert(polygons.first!.contains(CGPoint(x: 1, y: 0)))
        
        polygon1 = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 3), CGPoint(x: 3, y: 3), CGPoint(x: 3, y: 0)]
        polygon2 = [CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 2), CGPoint(x: 2, y: 2), CGPoint(x: 2, y: 1)]
        
        polygons = Clipper.differencePolygon(polygon1, fromPolygon: polygon2)
        XCTAssertFalse(polygons.isEmpty)
        XCTAssertEqual(polygons.count, 2)
        XCTAssert(polygons.first!.contains(CGPoint(x: 0, y: 0)))
        XCTAssert(polygons.first!.contains(CGPoint(x: 0, y: 3)))
        XCTAssert(polygons.first!.contains(CGPoint(x: 3, y: 3)))
        XCTAssert(polygons.first!.contains(CGPoint(x: 3, y: 0)))
        XCTAssert(polygons.last!.contains(CGPoint(x: 1, y: 1)))
        XCTAssert(polygons.last!.contains(CGPoint(x: 1, y: 2)))
        XCTAssert(polygons.last!.contains(CGPoint(x: 2, y: 2)))
        XCTAssert(polygons.last!.contains(CGPoint(x: 2, y: 1)))
    }
    
    func testIntersect() {
        var polygon1: Polygon = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 0)]
        var polygon2: Polygon = [CGPoint(x: 0.5, y: 0.5), CGPoint(x: 0.5, y: 1.5), CGPoint(x: 1.5, y: 1.5), CGPoint(x: 1.5, y: 0.5)]
        
        var polygons = Clipper.intersectPolygon(polygon1, withPolygon: polygon2)
        XCTAssertFalse(polygons.isEmpty)
        XCTAssertEqual(polygons.count, 1)
        
        let intersectPolygon = polygons.first!
        XCTAssertFalse(intersectPolygon.isEmpty)
        XCTAssertEqual(intersectPolygon.count, 4)
        XCTAssert(intersectPolygon.contains(CGPoint(x: 0.5, y: 0.5)))
        XCTAssert(intersectPolygon.contains(CGPoint(x: 0.5, y: 1)))
        XCTAssert(intersectPolygon.contains(CGPoint(x: 1, y: 1)))
        XCTAssert(intersectPolygon.contains(CGPoint(x: 1, y: 0.5)))
        
        polygon1 = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 0)]
        polygon2 = [CGPoint(x: 2, y: 2), CGPoint(x: 2, y: 3), CGPoint(x: 3, y: 3), CGPoint(x: 3, y: 2)]
        
        polygons = Clipper.intersectPolygon(polygon1, withPolygon: polygon2)
        XCTAssert(polygons.isEmpty)
        XCTAssertEqual(polygons.count, 0)
    }

    func testXor() {
        var polygon1: Polygon = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 0)]
        var polygon2: Polygon = [CGPoint(x: 0.5, y: 0.5), CGPoint(x: 0.5, y: 1.5), CGPoint(x: 1.5, y: 1.5), CGPoint(x: 1.5, y: 0.5)]
        
        var polygons = Clipper.xorPolygon(polygon1, withPolygon: polygon2)
        XCTAssertFalse(polygons.isEmpty)
        XCTAssertEqual(polygons.count, 2)
        XCTAssertEqual(polygons.first!.count, 6)
        XCTAssertEqual(polygons.last!.count, 6)
        
        polygon1 = [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 0)]
        polygon2 = [CGPoint(x: 2, y: 2), CGPoint(x: 2, y: 3), CGPoint(x: 3, y: 3), CGPoint(x: 3, y: 2)]
        
        polygons = Clipper.xorPolygon(polygon1, withPolygon: polygon2)
        XCTAssertFalse(polygons.isEmpty)
        XCTAssertEqual(polygons.count, 2)
        XCTAssertEqual(polygons.first!.count, 4)
        XCTAssertEqual(polygons.last!.count, 4)
    }
}
