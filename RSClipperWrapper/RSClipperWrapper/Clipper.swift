//
//  Clipper.swift
//  RSClipperWrapper
//
//  Created by Matthias Fey on 07.08.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

import UIKit

/// The `Clipper` class performs polygon clipping - union, difference,
/// intersection & exclusive-or. `Clipper` is built as a wrapper of the open source
/// Clipper library written in C++ by Angus Johnson.
final public class Clipper {
    
    /// Constructs and returns the union of an array of polygons with an
    /// array of polygons.
    public class func unionPolygons(polygons1: [[CGPoint]], withPolygons polygons2: [[CGPoint]]) -> [[CGPoint]] {
        return (_Clipper.unionPolygons(polygons1.map { $0.map { NSValue(CGPoint: $0) } } as [AnyObject], withPolygons: polygons2.map { $0.map { NSValue(CGPoint: $0) } } as [AnyObject]) as! [[NSValue]]).map { $0.map { $0.CGPointValue() }
        }
    }

    /// Constructs and returns the difference of an array of polygons
    /// from an array of polygons.
    public class func differencePolygons(polygons1: [[CGPoint]], fromPolygons polygons2: [[CGPoint]]) -> [[CGPoint]] {
        return (_Clipper.differencePolygons(polygons1.map { $0.map { NSValue(CGPoint: $0) } } as [AnyObject], fromPolygons: polygons2.map { $0.map { NSValue(CGPoint: $0) } } as [AnyObject]) as! [[NSValue]]).map { $0.map { $0.CGPointValue() }
        }
    }
    
    /// Constructs and returns the intersection of an array of polygons
    /// with an array of polygons.
    public class func intersectPolygons(polygons1: [[CGPoint]], withPolygons polygons2: [[CGPoint]]) -> [[CGPoint]] {
        return (_Clipper.intersectPolygons(polygons1.map { $0.map { NSValue(CGPoint: $0) } } as [AnyObject], withPolygons: polygons2.map { $0.map { NSValue(CGPoint: $0) } } as [AnyObject]) as! [[NSValue]]).map { $0.map { $0.CGPointValue() }
        }
    }
    
    /// Constructs and returns the exclusive-or boolean operation of an array of polygons
    /// with an array of polygons.
    public class func xorPolygons(polygons1: [[CGPoint]], withPolygons polygons2: [[CGPoint]]) -> [[CGPoint]] {
        return (_Clipper.xorPolygons(polygons1.map { $0.map { NSValue(CGPoint: $0) } } as [AnyObject], withPolygons: polygons2.map { $0.map { NSValue(CGPoint: $0) } } as [AnyObject]) as! [[NSValue]]).map { $0.map { $0.CGPointValue() }
        }
    }
}
