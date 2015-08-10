//
//  Scene.swift
//  Example
//
//  Created by Matthias Fey on 10.08.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

import SpriteKit
import RSClipperWrapper

class Scene : SKScene {
    
    let polygon1: Polygon = [CGPoint(x: -50, y: -50), CGPoint(x: -50, y: 25), CGPoint(x: 25, y: 25), CGPoint(x: 25, y: -50)]
    let polygon2: Polygon = [CGPoint(x: -25, y: -25), CGPoint(x: -25, y: 50), CGPoint(x: 50, y: 50), CGPoint(x: 50, y: -25)]
    
    override func didMoveToView(view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let polygonNode1 = SKShapeNode()
        polygonNode1.strokeColor = SKColor.whiteColor()
        polygonNode1.lineWidth = 1
        polygonNode1.path = CGPath.pathOfPolygons([polygon1])
        addChild(polygonNode1)
        
        let polygonNode2 = SKShapeNode()
        polygonNode2.strokeColor = SKColor.whiteColor()
        polygonNode2.lineWidth = 1
        polygonNode2.path = CGPath.pathOfPolygons([polygon2])
        addChild(polygonNode2)
        
        let clipperPolygon = Clipper.intersectPolygon(polygon1, withPolygon: polygon2)
        
        let clipperNode = SKShapeNode()
        clipperNode.strokeColor = SKColor.whiteColor()
        clipperNode.lineWidth = 1
        clipperNode.fillColor = SKColor.redColor()
        clipperNode.zPosition = -1
        clipperNode.path = CGPath.pathOfPolygons(clipperPolygon)
        addChild(clipperNode)
    }
}

extension CGPath {
    
    class func pathOfPolygons(polygons: [Polygon]) -> CGPath {
        let path = CGPathCreateMutable()
        for polygon in polygons {
            for (index, point) in polygon.enumerate() {
                if index == 0 { CGPathMoveToPoint(path, nil, point.x, point.y) }
                else { CGPathAddLineToPoint(path, nil, point.x, point.y) }
            }
            if polygon.count > 2 { CGPathCloseSubpath(path) }
        }
        
        return path
    }
}
