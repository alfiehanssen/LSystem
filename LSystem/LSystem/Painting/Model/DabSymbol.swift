//
//  DabSymbol.swift
//  LSystem
//
//  Created by Hanssen, Alfie on 4/8/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//

import UIKit
import CoreGraphics

public class DabSymbol: DrawableSymbol
{
    let markLength: CGFloat
    
    override var bezierPath: UIBezierPath
    {
        let path = UIBezierPath()
        
        let segment = (self.markLength - self.markWidth) / 2.0
        
        var point = CGPoint(x: self.center.x, y: self.center.y - segment)
        path.moveToPoint(point)
        
        point = CGPoint(x: point.x, y: point.y + 2 * segment)
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