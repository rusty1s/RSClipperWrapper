//
//  ClipperWrapper.swift
//  RSClipperWrapper
//
//  Created by Matthias Fey on 07.08.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

// MARK: Polygon

public class Polygon : ArrayLiteralConvertible {
    
    // MARK: Associated types
    
    public typealias Element = CGPoint
    
    // MARK: Initializers
    
    public init() {
        _polygon = _Polygon()
    }
    
    public convenience init<S : SequenceType where S.Generator.Element == CGPoint>(_ sequence: S) {
        self.init()
        for element in sequence { append(element) }
    }
    
    public required convenience init(arrayLiteral elements: Element...) {
        self.init()
        for element in elements { append(element) }
    }
    
    // MARK: Instance variables
    
    private var _polygon: _Polygon
    
    var area: CGFloat { return _polygon.area }
    
    // MARK: Instance methods
    
    func append(point: CGPoint) {
        _polygon.append(point)
    }
    
    func insert(point: CGPoint, atIndex i: Int) {
        _polygon.insert(point, atIndex: Int32(i))
    }
    
    func removeLast() -> CGPoint {
        let point = self[count-1]
        _polygon.removeLast()
        return point
    }
    
    func removeAtIndex(index: Int) -> CGPoint {
        let point = self[index]
        _polygon.removeAtIndex(Int32(index))
        return point
    }
    
    func removeAll() {
        _polygon.removeAll()
    }
}

// MARK: SequenceType

extension Polygon : SequenceType {
    
    public typealias Generator = AnyGenerator<CGPoint>
    
    public func generate() -> Generator {
        var nextIndex = 0
        
        return anyGenerator {
            if nextIndex < Int(self._polygon.count) { return self[nextIndex++] }
            else { return nil }
        }
    }
}

// MARK: MutableCollectionType

extension Polygon : MutableCollectionType {
    
    public typealias Index = Int
    
    public var startIndex: Index { return 0 }
    
    public var endIndex: Index { return Int(_polygon.count) }
    
    public subscript(position: Index) -> Generator.Element {
        set { insert(newValue, atIndex: position) }
        get { return _polygon.objectAtIndex(Int32(position)).CGPointValue() }
    }
    
    public var count: Index.Distance { return endIndex }
}

// MARK: CustomStringConvertible

extension Polygon : CustomStringConvertible, CustomDebugStringConvertible {
    
    /// A textual representation of `self`.
    public var description: String { return Array(self).description }
    
    /// A textual representation of `self`, suitable for debugging.
    public var debugDescription: String { return "Polygon\(self)" }
}

// MARK: Clipper

public class Clipper {
    
    class func unionPolygon(polygon1: Polygon, withPolygon polygon2: Polygon) -> [Polygon] {
        return unionPolygons([polygon1], withPolygons: [polygon2])
    }
    
    class func unionPolygons(polygons1: [Polygon], withPolygons polygons2: [Polygon]) -> [Polygon] {
        return _Clipper.unionPolygons(polygons1, withPolygons: polygons2) as! [Polygon]
    }
    
    class func differencePolygon(polygon1: Polygon, fromPolygon polygon2: Polygon) -> [Polygon] {
        return differencePolygons([polygon1], fromPolygons: [polygon2])
    }
    
    class func differencePolygons(polygons1: [Polygon], fromPolygons polygons2: [Polygon]) -> [Polygon] {
        return _Clipper.differencePolygons(polygons1, fromPolygons: polygons2) as! [Polygon]
    }
    
    class func intersectPolygon(polygon1: Polygon, withPolygon polygon2: Polygon) -> [Polygon] {
        return intersectPolygons([polygon1], withPolygons: [polygon2])
    }
    
    class func intersectPolygons(polygons1: [Polygon], withPolygons polygons2: [Polygon]) -> [Polygon] {
        return _Clipper.intersectPolygons(polygons1, withPolygons: polygons2) as! [Polygon]
    }
    
    class func xorPolygon(polygon1: Polygon, withPolygon polygon2: Polygon) -> [Polygon] {
        return xorPolygons([polygon1], withPolygons: [polygon2])
    }
    
    class func xorPolygons(polygons1: [Polygon], withPolygons polygons2: [Polygon]) -> [Polygon] {
        return _Clipper.xorPolygons(polygons1, withPolygons: polygons2) as! [Polygon]
    }
}
