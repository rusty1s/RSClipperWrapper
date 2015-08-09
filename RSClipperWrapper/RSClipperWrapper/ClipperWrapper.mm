//
//  ClipperWrapper.mm
//  RSClipperWrapper
//
//  Created by Matthias Fey on 07.08.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

#import "ClipperWrapper.h"

#include "clipper.hpp"
#include <cmath>

#define kClipperScale 1000000.0f

@implementation _Polygon
{
    @public
    ClipperLib::Path _path;
}

-(void)append:(CGPoint)point {
    _path.push_back(ClipperLib::IntPoint(kClipperScale*point.x, kClipperScale*point.y));
}

-(void)insert:(CGPoint)point atIndex:(int)index {
    ClipperLib::Path::iterator it = _path.begin() + index;
    _path.insert(it, ClipperLib::IntPoint(kClipperScale*point.x, kClipperScale*point.y));
}

-(NSValue *)valueAtIndex:(int)index {
    CGPoint point = CGPointMake(_path[index].X/kClipperScale, _path[index].Y/kClipperScale);
    return [NSValue valueWithCGPoint:point];
}

-(CGPoint)removeLast {
    CGPoint point = [self valueAtIndex:(int) self.count-1].CGPointValue;
    _path.pop_back();
    return point;
}

-(CGPoint)removeAtIndex:(int)index {
    CGPoint point = [self valueAtIndex:index].CGPointValue;
    _path.erase(_path.begin()+index);
    return point;
}

-(void)removeAll {
    _path.clear();
}

-(NSUInteger)count {
    return _path.size();
}

-(CGFloat)area {
    return std::abs(ClipperLib::Area(_path))/kClipperScale/kClipperScale;
}

@end

@implementation _Clipper

+ (NSArray *) unionPolygons:(NSArray *)polygons1 withPolygons:(NSArray *)polygons2 {
    printf("3");
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
    ClipperLib::Clipper _clipper;
    _clipper.StrictlySimple();
    
    for (_Polygon *polygon : polygons1) {
        _clipper.AddPath(polygon->_path, ClipperLib::PolyType::ptSubject, YES);
    }
    
    for (_Polygon *polygon : polygons2) {
        _clipper.AddPath(polygon->_path, ClipperLib::PolyType::ptClip, YES);
    }
    
    ClipperLib::Paths _paths;
    _clipper.Execute(clipType, _paths);
    
    NSMutableArray *polygons = [NSMutableArray arrayWithCapacity:_paths.size()];
    for (int i = 0; i < _paths.size(); i++) {
        _Polygon *polygon = [[_Polygon alloc] init];
        polygon->_path = _paths[i];
        [polygons addObject:polygon];
    }
    
    return polygons;
}

@end
