//
//  PaintingSymbols.swift
//  Example-iOS
//
//  Created by Hanssen, Alfie on 4/7/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//

import Foundation
import LSystem
import UIKit

class XSymbol: DrawableSymbol
{
    let markLength: CGFloat
    
    override var bezierPath: UIBezierPath
    {
        let path = UIBezierPath()

        let offset = ((self.markLength - self.markWidth) / 2.0) / sqrt(2)
        var point = CGPoint(x: self.center.x - offset, y: self.center.y - offset)
        path.moveToPoint(point)
        
        let segment = self.markLength - self.markWidth
        let segmentOffset = segment / sqrt(2)
        point = CGPoint(x: point.x + segmentOffset, y: point.y + segmentOffset)
        path.addLineToPoint(point)

        point = CGPoint(x: self.center.x - offset, y: self.center.y + offset)
        path.moveToPoint(point)

        point = CGPoint(x: point.x + segmentOffset, y: point.y - segmentOffset)
        path.addLineToPoint(point)

        path.lineWidth = self.markWidth
        path.lineCapStyle = .Round
        
        return path
    }

    init(center: CGPoint, markWidth: CGFloat, markLength: CGFloat)
    {
        self.markLength = markLength

        super.init(center: center, markWidth: markWidth)
    }
}

class OSymbol: DrawableSymbol
{
    let diameter: CGFloat

    override var bezierPath: UIBezierPath
    {
        let path = UIBezierPath()

        let radius = self.diameter / 2.0
        path.addArcWithCenter(self.center, radius: radius, startAngle: CGFloat(0).radians(), endAngle: CGFloat(360).radians(), clockwise: true)
        
        path.usesEvenOddFillRule = true
        
        path.lineWidth = self.markWidth
        path.lineCapStyle = .Round
        
        return path
    }

    init(center: CGPoint, markWidth: CGFloat, diameter: CGFloat)
    {
        self.diameter = diameter

        super.init(center: center, markWidth: markWidth)
    }
}

class DrawableSymbol: Symbol
{
    let center: CGPoint
    let markWidth: CGFloat
    
    var alpha: CGFloat = 1.0
    var blendMode: CGBlendMode = .Normal
    
    var fillColor: UIColor?
    var strokeColor: UIColor?
    
    var bezierPath: UIBezierPath
    {
        assertionFailure("Subclasses must override bezierPath")
        
        return UIBezierPath()
    }

    init(center: CGPoint, markWidth: CGFloat)
    {
        self.center = center
        self.markWidth = markWidth
    }
}
