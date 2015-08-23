//
//  _Clipper.h
//  RSClipperWrapper
//
//  Created by Matthias Fey on 07.08.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface _Clipper : NSObject

+ (NSArray *) unionPolygons:(NSArray *)polygons1 withPolygons:(NSArray *)polygons2;
+ (NSArray *) differencePolygons:(NSArray *)polygons1 fromPolygons:(NSArray *)polygons2;
+ (NSArray *) intersectPolygons:(NSArray *)polygons1 withPolygons:(NSArray *)polygons2;
+ (NSArray *) xorPolygons:(NSArray *)polygons1 withPolygons:(NSArray *)polygons2;

@end
