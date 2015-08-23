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

+ (NSArray *) unionPolygons:(NSArray *)polygons1 withPolygons:(NSArray *)polygons2 {
    return [_Clipper executePolygons:polygons1 withPolygons:polygons2 andClipType:ClipperLib::ClipType::ctUnion];
}

+ (NSArray *) differencePolygons:(NSArray *)polygons1 fromPolygons:(NSArray *)polygons2 {
    return [_Clipper executePolygons:polygons1 withPolygons:polygons2 andClipType:ClipperLib::ClipType::ctDifference];
}

+ (NSArray *) intersectPolygons:(NSArray *)polygons1 withPolygons:(NSArray *)polygons2 {
    return [_Clipper executePolygons:polygons1 withPolygons:polygons2 andClipType:ClipperLib::ClipType::ctIntersection];
}

+ (NSArray *) xorPolygons:(NSArray *)polygons1 withPolygons:(NSArray *)polygons2 {
    return [_Clipper executePolygons:polygons1 withPolygons:polygons2 andClipType:ClipperLib::ClipType::ctXor];
}

+(NSArray *) executePolygons:(NSArray *)polygons1 withPolygons:(NSArray *)polygons2 andClipType:(ClipperLib::ClipType)clipType {
    
    ClipperLib::Clipper clipper;
    clipper.StrictlySimple();
    
    for (NSArray *polygon : polygons1) {
        ClipperLib::Path path;
        for (NSValue *vertex : polygon) {
            path.push_back(ClipperLib::IntPoint(kClipperScale*vertex.CGPointValue.x, kClipperScale*vertex.CGPointValue.y));
        }
        clipper.AddPath(path, ClipperLib::PolyType::ptSubject, YES);
    }
    
    for (NSArray *polygon : polygons2) {
        ClipperLib::Path path;
        for (NSValue *vertex : polygon) {
            path.push_back(ClipperLib::IntPoint(kClipperScale*vertex.CGPointValue.x, kClipperScale*vertex.CGPointValue.y));
        }
        clipper.AddPath(path, ClipperLib::PolyType::ptClip, YES);
    }
    
    ClipperLib::Paths paths;
    clipper.Execute(clipType, paths);
    
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

@end
