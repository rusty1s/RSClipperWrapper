//
//  _Clipper.mm
//  RSClipperWrapper
//
//  Created by Matthias Fey on 07.08.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

#import "_Clipper.h"

#include "clipper.hpp"

#define kClipperScale 1000000.0f

@implementation _Clipper

+ (NSArray *) unionPolygons:(NSArray *)subjPolygons subjFillType:(_FillType)subjFillType withPolygons:(NSArray *)clipPolygons clipFillType:(_FillType)clipFillType {
    
    return [_Clipper executePolygons:subjPolygons subjFillType:subjFillType withPolygons:clipPolygons clipFillType:clipFillType clipType:ClipperLib::ClipType::ctUnion];
}

+ (NSArray *) differencePolygons:(NSArray *)subjPolygons subjFillType:(_FillType)subjFillType fromPolygons:(NSArray *)clipPolygons clipFillType:(_FillType)clipFillType {
    
    return [_Clipper executePolygons:subjPolygons subjFillType:subjFillType withPolygons:clipPolygons clipFillType:clipFillType clipType:ClipperLib::ClipType::ctDifference];
}

+ (NSArray *) intersectPolygons:(NSArray *)subjPolygons subjFillType:(_FillType)subjFillType withPolygons:(NSArray *)clipPolygons clipFillType:(_FillType)clipFillType {
    
    return [_Clipper executePolygons:subjPolygons subjFillType:subjFillType withPolygons:clipPolygons clipFillType:clipFillType clipType:ClipperLib::ClipType::ctIntersection];
}

+ (NSArray *) xorPolygons:(NSArray *)subjPolygons subjFillType:(_FillType)subjFillType withPolygons:(NSArray *)clipPolygons clipFillType:(_FillType)clipFillType {
    
    return [_Clipper executePolygons:subjPolygons subjFillType:subjFillType withPolygons:clipPolygons clipFillType:clipFillType clipType:ClipperLib::ClipType::ctXor];
}

+(NSArray *) executePolygons:(NSArray *)subjPolygons subjFillType:(_FillType)subjFillType withPolygons:(NSArray *)clipPolygons clipFillType:(_FillType)clipFillType clipType:(ClipperLib::ClipType)clipType {
    
    ClipperLib::Clipper clipper;
    clipper.StrictlySimple();
    
    for (NSArray *polygon : subjPolygons) {
        ClipperLib::Path path;
        for (NSValue *vertex : polygon) {
            path.push_back(ClipperLib::IntPoint(kClipperScale*vertex.CGPointValue.x, kClipperScale*vertex.CGPointValue.y));
        }
        clipper.AddPath(path, ClipperLib::PolyType::ptSubject, YES);
    }
    
    for (NSArray *polygon : clipPolygons) {
        ClipperLib::Path path;
        for (NSValue *vertex : polygon) {
            path.push_back(ClipperLib::IntPoint(kClipperScale*vertex.CGPointValue.x, kClipperScale*vertex.CGPointValue.y));
        }
        clipper.AddPath(path, ClipperLib::PolyType::ptClip, YES);
    }
    
    ClipperLib::Paths paths;
    
    ClipperLib::PolyFillType _subjFillType;
    ClipperLib::PolyFillType _clipFillType;
    
    switch (subjFillType) {
        case EvenOdd:
            _subjFillType = ClipperLib::PolyFillType::pftEvenOdd;
            break;
        case NonZero:
            _subjFillType = ClipperLib::PolyFillType::pftNonZero;
            break;
        case Positive:
            _subjFillType = ClipperLib::PolyFillType::pftPositive;
            break;
        case Negative:
            _subjFillType = ClipperLib::PolyFillType::pftNegative;
            break;
    }
    
    switch (clipFillType) {
        case EvenOdd:
            _clipFillType = ClipperLib::PolyFillType::pftEvenOdd;
            break;
        case NonZero:
            _clipFillType = ClipperLib::PolyFillType::pftNonZero;
            break;
        case Positive:
            _clipFillType = ClipperLib::PolyFillType::pftPositive;
            break;
        case Negative:
            _clipFillType = ClipperLib::PolyFillType::pftNegative;
            break;
    }
    
    clipper.Execute(clipType, paths, _subjFillType, _clipFillType);

    NSMutableArray *polygons = [NSMutableArray arrayWithCapacity:paths.size()];
    for (int i = 0; i < paths.size(); i++) {
        ClipperLib::Path path = paths[i];

        NSMutableArray *polygon = [NSMutableArray arrayWithCapacity:path.size()];
        for (int j = 0; j < path.size(); j++) {
            [polygon addObject:[NSValue valueWithCGPoint:CGPointMake(path[j].X/kClipperScale, path[j].Y/kClipperScale)]];
        }
        
        [polygons addObject:polygon];
    }
    
    return polygons;
}

+ (Boolean) polygon:(NSArray *)polygon containsPoint:(CGPoint)point {
    
    ClipperLib::IntPoint aPoint = ClipperLib::IntPoint(kClipperScale*point.x, kClipperScale*point.y);
    
    ClipperLib::Path path;
    for (NSValue *vertex : polygon) {
        path.push_back(ClipperLib::IntPoint(kClipperScale*vertex.CGPointValue.x, kClipperScale*vertex.CGPointValue.y));
    }
    
    int result = ClipperLib::PointInPolygon(aPoint, path);
    
    return result != 0;
}

@end
