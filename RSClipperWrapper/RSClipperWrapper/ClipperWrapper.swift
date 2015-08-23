//
//  ClipperWrapper.swift
//  RSClipperWrapper
//
//  Created by Matthias Fey on 07.08.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

import UIKit

// MARK: Polygon

/// A `Polygon` is an ordered list that contains elements of type `CGPoint`.
/// The `Polygon` class is built as a wrapper of `std::vector` in C++ and
/// therefore should not be used otherwise as clipping polygons.
///
/// `Polygon` behaves just like the `Array` implementation in Swift except
/// that it can only hold points of the type `CGPoint`.
final public class Polygon : ArrayLiteralConvertible {
    
    // MARK: Associated types
    
    /// The type of element stored by this `Polygon`.
    public typealias Element = CGPoint
    
    // MARK: Initializers
    
    /// Construct an empty Polygon.
    public init() {
        _polygon = _Polygon()
    }
    
    /// Construct from an arbitrary sequence with elements of type `CGPoint`.
    public convenience init<S : SequenceType where S.Generator.Element == CGPoint>(_ sequence: S) {
        self.init()
        for element in sequence { append(element) }
    }
    
    /// Create an instance containing elements.
    public required convenience init(arrayLiteral elements: Element...) {
        self.init()
        for element in elements { append(element) }
    }
    
    // MARK: Instance variables
    
    private var _polygon: _Polygon
    
    /// The area of the Polygon.
    public var area: CGFloat { return _polygon.area }
    
    // MARK: Instance methods
    
    /// Append a `CGPoint` to the Polygon.
    public func append(point: CGPoint) {
        _polygon.append(point)
    }
    
    /// Insert a `CGPoint` at index `i`.
    public func insert(point: CGPoint, atIndex i: Int) {
        _polygon.insert(point, atIndex: Int32(i))
    }
    
    /// Remove a point from the end of the Polygon in O(1).
    public func removeLast() -> CGPoint {
        let point = self[count-1]
        _polygon.removeLast()
        return point
    }
    
    /// Remove and return the point at index `i`.
    public func removeAtIndex(index: Int) -> CGPoint {
        let point = self[index]
        _polygon.removeAtIndex(Int32(index))
        return point
    }
    
    /// Remove all points.
    public func removeAll() {
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
        set {
            removeAtIndex(position)
            insert(newValue, atIndex: position)
        }
        get { return _polygon.valueAtIndex(Int32(position)).CGPointValue() }
    }
    
    public var count: Index.Distance { return endIndex }
}

// MARK: CustomStringConvertible

extension Polygon : CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String { return "\(Array(self))" }
    
    public var debugDescription: String { return "Polygon\(self)" }
}

// MARK: Clipper

/// The `Clipper` class performs polygon clipping -  union, difference,
/// intersection & exclusive-or. `Clipper` is built as a wrapper of the open source
/// Clipper library written in C++ by Angus Johnson.
final public class Clipper {
    
    /// Constructs and returns the union of a polygon with a polygon.
    public class func unionPolygon(polygon1: Polygon, withPolygon polygon2: Polygon) -> [Polygon] {
        return unionPolygons([polygon1], withPolygons: [polygon2])
    }
    
    /// Constructs and returns the union of an array of polygons with an
    /// array of polygons.
    public class func unionPolygons(polygons1: [Polygon], withPolygons polygons2: [Polygon]) -> [Polygon] {
        return _Clipper.unionPolygons(polygons1.map { $0._polygon }, withPolygons: polygons2.map { $0._polygon }).map {
            let polygon = Polygon()
            polygon._polygon = $0 as! _Polygon
            return polygon
        }
    }
    
    /// Constructs and returns the difference of a polygon from a polygon.
    public class func differencePolygon(polygon1: Polygon, fromPolygon polygon2: Polygon) -> [Polygon] {
        return differencePolygons([polygon1], fromPolygons: [polygon2])
    }
    
    /// Constructs and returns the difference of an array of polygons
    /// from an array of polygons.
    public class func differencePolygons(polygons1: [Polygon], fromPolygons polygons2: [Polygon]) -> [Polygon] {
        return _Clipper.differencePolygons(polygons1.map { $0._polygon }, fromPolygons: polygons2.map { $0._polygon }).map {
            let polygon = Polygon()
            polygon._polygon = $0 as! _Polygon
            return polygon
        }
    }
    
     /// Constructs and returns the intersection of a polygon with a polygon.
    public class func intersectPolygon(polygon1: Polygon, withPolygon polygon2: Polygon) -> [Polygon] {
        return intersectPolygons([polygon1], withPolygons: [polygon2])
    }
    
    /// Constructs and returns the intersection of an array of polygons
    /// with an array of polygons.
    public class func intersectPolygons(polygons1: [Polygon], withPolygons polygons2: [Polygon]) -> [Polygon] {
        return _Clipper.intersectPolygons(polygons1.map { $0._polygon }, withPolygons: polygons2.map { $0._polygon }).map {
            let polygon = Polygon()
            polygon._polygon = $0 as! _Polygon
            return polygon
        }
    }
    
    /// Constructs and returns the exclusive-or boolean operation of a polygon with
    /// a polygon.
    public class func xorPolygon(polygon1: Polygon, withPolygon polygon2: Polygon) -> [Polygon] {
        return xorPolygons([polygon1], withPolygons: [polygon2])
    }
    
    /// Constructs and returns the exclusive-or boolean operation of an array of polygons
    /// with an array of polygons.
    public class func xorPolygons(polygons1: [Polygon], withPolygons polygons2: [Polygon]) -> [Polygon] {
        return _Clipper.xorPolygons(polygons1.map { $0._polygon }, withPolygons: polygons2.map { $0._polygon }).map {
            let polygon = Polygon()
            polygon._polygon = $0 as! _Polygon
            return polygon
        }
    }
}
