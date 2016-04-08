//
//  XSymbol.swift
//  LSystem
//
//  Created by Hanssen, Alfie on 4/8/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//

import UIKit
import CoreGraphics

public class XSymbol: DrawableSymbol
{
    let markLength: CGFloat
    
    override var bezierPath: UIBezierPath
    {
        let path = UIBezierPath()
        
        let offset = ((self.markLength - self.brushDiameter) / 2.0) / sqrt(2)
        var point = CGPoint(x: self.center.x - offset, y: self.center.y - offset)
        path.moveToPoint(point)
        
        let segment = self.markLength - self.brushDiameter
        let segmentOffset = segment / sqrt(2)
        point = CGPoint(x: point.x + segmentOffset, y: point.y + segmentOffset)
        path.addLineToPoint(point)
        
        point = CGPoint(x: self.center.x - offset, y: self.center.y + offset)
        path.moveToPoint(point)
        
        point = CGPoint(x: point.x + segmentOffset, y: point.y - segmentOffset)
        path.addLineToPoint(point)
        
        path.lineWidth = self.brushDiameter
        path.lineCapStyle = .Round
        
        return path
    }
    
    init(center: CGPoint, brushDiameter: CGFloat, markLength: CGFloat)
    {
        self.markLength = markLength
        
        super.init(center: center, brushDiameter: brushDiameter)
    }
}