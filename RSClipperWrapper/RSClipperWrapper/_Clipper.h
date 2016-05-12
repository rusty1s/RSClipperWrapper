//
//  _Clipper.h
//  RSClipperWrapper
//
//  Created by Matthias Fey on 07.08.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, _FillType) {
    EvenOdd,
    NonZero,
    Positive,
    Negative
};

@interface _Clipper : NSObject

+ (NSArray *) unionPolygons:(NSArray *)subjPolygons subjFillType:(_FillType)subjFillType withPolygons:(NSArray *)clipPolygons clipFillType:(_FillType)clipFillType;
+ (NSArray *) differencePolygons:(NSArray *)subjPolygons subjFillType:(_FillType)subjFillType fromPolygons:(NSArray *)clipPolygons clipFillType:(_FillType)clipFillType;
+ (NSArray *) intersectPolygons:(NSArray *)subjPolygons subjFillType:(_FillType)subjFillType withPolygons:(NSArray *)clipPolygons clipFillType:(_FillType)clipFillType;
+ (NSArray *) xorPolygons:(NSArray *)subjPolygons subjFillType:(_FillType)subjFillType withPolygons:(NSArray *)clipPolygons clipFillType:(_FillType)clipFillType;
+ (Boolean) polygon:(NSArray *)polygon containsPoint:(CGPoint)point;

@end
