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
    
    public enum FillType {
        case evenOdd
        case nonZero
        case positive
        case negative
        
        fileprivate var mapped: _FillType {
            switch self {
                case .evenOdd: return _FillType.EvenOdd
                case .nonZero: return _FillType.Negative
                case .positive: return _FillType.Positive
                case .negative: return _FillType.Negative
            }
        }
    }
    
    /// Constructs and returns the union of an array of polygons with an
    /// array of polygons.
    public class func unionPolygons(_ subjPolygons: [[CGPoint]], subjFillType: FillType = .evenOdd, withPolygons clipPolygons: [[CGPoint]], clipFillType: FillType = .evenOdd) -> [[CGPoint]] {
        
        return (_Clipper.unionPolygons(subjPolygons.map { $0.map { NSValue(cgPoint: $0) } } as [AnyObject], subjFillType: subjFillType.mapped, withPolygons: clipPolygons.map { $0.map { NSValue(cgPoint: $0) } } as [AnyObject], clipFillType: clipFillType.mapped) as! [[NSValue]]).map { $0.map { $0.cgPointValue } }
    }

    /// Constructs and returns the difference of an array of polygons
    /// from an array of polygons.
    public class func differencePolygons(_ subjPolygons: [[CGPoint]], subjFillType: FillType = .evenOdd, fromPolygons clipPolygons: [[CGPoint]], clipFillType: FillType = .evenOdd) -> [[CGPoint]] {
        
        return (_Clipper.differencePolygons(subjPolygons.map { $0.map { NSValue(cgPoint: $0) } } as [AnyObject], subjFillType: subjFillType.mapped, fromPolygons: clipPolygons.map { $0.map { NSValue(cgPoint: $0) } } as [AnyObject], clipFillType: clipFillType.mapped) as! [[NSValue]]).map { $0.map { $0.cgPointValue } }
        }
    
    /// Constructs and returns the intersection of an array of polygons
    /// with an array of polygons.
    public class func intersectPolygons(_ subjPolygons: [[CGPoint]], subjFillType: FillType = .evenOdd, withPolygons clipPolygons: [[CGPoint]], clipFillType: FillType = .evenOdd) -> [[CGPoint]] {
        
        return (_Clipper.intersectPolygons(subjPolygons.map { $0.map { NSValue(cgPoint: $0) } } as [AnyObject], subjFillType: subjFillType.mapped, withPolygons: clipPolygons.map { $0.map { NSValue(cgPoint: $0) } } as [AnyObject], clipFillType: clipFillType.mapped) as! [[NSValue]]).map { $0.map { $0.cgPointValue } }
        }
    
    /// Constructs and returns the exclusive-or boolean operation of an array of polygons
    /// with an array of polygons.
    public class func xorPolygons(_ subjPolygons: [[CGPoint]], subjFillType: FillType = .evenOdd, withPolygons clipPolygons: [[CGPoint]], clipFillType: FillType = .evenOdd) -> [[CGPoint]] {
        
        return (_Clipper.xorPolygons(subjPolygons.map { $0.map { NSValue(cgPoint: $0) } } as [AnyObject], subjFillType: subjFillType.mapped, withPolygons: clipPolygons.map { $0.map { NSValue(cgPoint: $0) } } as [AnyObject], clipFillType: clipFillType.mapped) as! [[NSValue]]).map { $0.map { $0.cgPointValue } }
        }
    
    /// Checks and Returns if a polygon contains a point
    public class func polygonContainsPoint(_ polygon: [CGPoint], point:CGPoint) -> Bool {
        return _Clipper.polygon(polygon.map { NSValue(cgPoint: $0) }, contains: point)
    }
}
