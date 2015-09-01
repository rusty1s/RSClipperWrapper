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
        case EvenOdd
        case NonZero
        case Positive
        case Negative
        
        private var mapped: _FillType {
            switch self {
                case .EvenOdd: return _FillType.EvenOdd
                case .NonZero: return _FillType.Negative
                case .Positive: return _FillType.Positive
                case .Negative: return _FillType.Negative
            }
        }
    }
    
    /// Constructs and returns the union of an array of polygons with an
    /// array of polygons.
    public class func unionPolygons(subjPolygons: [[CGPoint]], subjFillType: FillType = .EvenOdd, withPolygons clipPolygons: [[CGPoint]], clipFillType: FillType = .EvenOdd) -> [[CGPoint]] {
        
        return (_Clipper.unionPolygons(subjPolygons.map { $0.map { NSValue(CGPoint: $0) } } as [AnyObject], subjFillType: subjFillType.mapped, withPolygons: clipPolygons.map { $0.map { NSValue(CGPoint: $0) } } as [AnyObject], clipFillType: clipFillType.mapped) as! [[NSValue]]).map { $0.map { $0.CGPointValue() } }
    }

    /// Constructs and returns the difference of an array of polygons
    /// from an array of polygons.
    public class func differencePolygons(subjPolygons: [[CGPoint]], subjFillType: FillType = .EvenOdd, fromPolygons clipPolygons: [[CGPoint]], clipFillType: FillType = .EvenOdd) -> [[CGPoint]] {
        
        return (_Clipper.differencePolygons(subjPolygons.map { $0.map { NSValue(CGPoint: $0) } } as [AnyObject], subjFillType: subjFillType.mapped, fromPolygons: clipPolygons.map { $0.map { NSValue(CGPoint: $0) } } as [AnyObject], clipFillType: clipFillType.mapped) as! [[NSValue]]).map { $0.map { $0.CGPointValue() } }
        }
    
    /// Constructs and returns the intersection of an array of polygons
    /// with an array of polygons.
    public class func intersectPolygons(subjPolygons: [[CGPoint]], subjFillType: FillType = .EvenOdd, withPolygons clipPolygons: [[CGPoint]], clipFillType: FillType = .EvenOdd) -> [[CGPoint]] {
        
        return (_Clipper.intersectPolygons(subjPolygons.map { $0.map { NSValue(CGPoint: $0) } } as [AnyObject], subjFillType: subjFillType.mapped, withPolygons: clipPolygons.map { $0.map { NSValue(CGPoint: $0) } } as [AnyObject], clipFillType: clipFillType.mapped) as! [[NSValue]]).map { $0.map { $0.CGPointValue() } }
        }
    
    /// Constructs and returns the exclusive-or boolean operation of an array of polygons
    /// with an array of polygons.
    public class func xorPolygons(subjPolygons: [[CGPoint]], subjFillType: FillType = .EvenOdd, withPolygons clipPolygons: [[CGPoint]], clipFillType: FillType = .EvenOdd) -> [[CGPoint]] {
        
        return (_Clipper.xorPolygons(subjPolygons.map { $0.map { NSValue(CGPoint: $0) } } as [AnyObject], subjFillType: subjFillType.mapped, withPolygons: clipPolygons.map { $0.map { NSValue(CGPoint: $0) } } as [AnyObject], clipFillType: clipFillType.mapped) as! [[NSValue]]).map { $0.map { $0.CGPointValue() } }
        }
}
