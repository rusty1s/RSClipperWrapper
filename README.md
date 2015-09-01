# RSClipperWrapper

`RSClipperWrapper` is a small and simple wrapper for [Clipper](http://www.angusj.com/delphi/clipper.php) - an open source freeware library for clipping polygons - by Angus Johnson implemented in **Swift**. The original *Clipper* sources of version 6.2.1 are distributed. *Clipper* is fast, has no errors even on complex polygons (inclusive holes) and comes with the [Boost Software License](http://www.boost.org/LICENSE_1_0.txt) and thus is free for both open source and commerical applications.

`RSClipperWrapper` contains the `Clipper` class to perform clipping on any amount of polygons - **union**, **difference**, **intersection** & **exclusive-or**.

![alt Union](union.png)
![alt Difference](difference.png)
![alt Intersection](intersect.png)
![alt Xor](xor.png)

## Example

1. Construct polygons, e.g.: `let polygon1 = [CGPoint(x: 0, y: 0), CGPoint(x: 10, y: 10), CGPoint(x: 20, 0)]`
2. Use on of the static functions of the `Clipper` class to perform a polygon clipping, e.g.: `Clipper.intersectPolygons([polygon1], withPolygons: [polygon2])`
3. That's it!

`RSClipperWrapper` contains an example project where you can play around with the four different ways of clipping polygons.

## Installation

`RSClipperWrapper` is not yet released on CocoaPod. Instead use

```
use_frameworks!

pod 'RSClipperWrapper', :git => 'https://github.com/rusty1s/RSClipperWrapper.git'
```

in your Podfile and run `pod install`.

## Documentation

### Clipper

	class Clipper { ... }

The `Clipper` class performs polygon clipping -  union, difference, intersection & exclusive-or. A set of polygons are represented as `[[CGPoint]]` - an array of polygons and a polygon is defined as a finite sequence of `CGPoint`.

#### Enumerations

	FillType

The winding rule used to present a polygon.

	enum FillType {
        case EvenOdd
        case NonZero
        case Positive
        case Negative
    }

#### Static methods

	class func unionPolygons(subjPolygons: [[CGPoint]], subjFillType: FillType, withPolygons clipPolygons: [[CGPoint]], clipFillType: FillType) -> [[CGPoint]]

Constructs and returns the union of an array of polygons with an array of polygons.

	class func differencePolygons(subjPolygons: [[CGPoint]], subjFillType: FillType, fromPolygons clipPolygons: [[CGPoint]], clipFillType: FillType) -> [[CGPoint]]

Constructs and returns the difference of an array of polygons from an array of polygons.

	class func intersectPolygons(subjPolygons: [[CGPoint]], subjFillType: FillType, withPolygons clipPolygons: [[CGPoint]], clipFillType: FillType) -> [[CGPoint]]

Constructs and returns the intersection of an array of polygons with an array of polygons.

	class func xorPolygons(subjPolygons: [[CGPoint]], subjFillType: FillType, withPolygons clipPolygons: [[CGPoint]], clipFillType: FillType) -> [[CGPoint]]

Constructs and returns the exclusive-or boolean operation of an array of polygons with an array of polygons.

The default values for `subjFillType` and `clipFillType` are `EvenOdd`.

## Additional information

`RSClipperWrapper` was developed and implemented for the use in *Dig Deeper - the Mining / Crafting / Trading game*. *Dig Depper* is currently in developement and has its own *GitHub* project [here](../../../DigDeeper).

![alt Dig Deeper](../../../DigDeeper/blob/master/logo.png)

## License

Copyright (c) 2015 Matthias Fey <matthias.fey@tu-dortmund.de>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.