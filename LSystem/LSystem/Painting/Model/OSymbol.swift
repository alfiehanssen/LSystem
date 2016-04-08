//
//  OSymbol.swift
//  LSystem
//
//  Created by Hanssen, Alfie on 4/8/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//

import UIKit
import CoreGraphics

public class OSymbol: DrawableSymbol
{
    let diameter: CGFloat
    
    override var bezierPath: UIBezierPath
    {
        let path = UIBezierPath()
        
        let radius = self.diameter / 2.0
        path.addArcWithCenter(self.center, radius: radius, startAngle: CGFloat(0).radians(), endAngle: CGFloat(360).radians(), clockwise: true)
        
        path.usesEvenOddFillRule = true
        
        path.lineWidth = self.brushDiameter
        path.lineCapStyle = .Round
        
        return path
    }
    
    init(center: CGPoint, brushDiameter: CGFloat, diameter: CGFloat)
    {
        assert(diameter > 0, "Diameter must be greater than 0.")

        self.diameter = diameter
        
        super.init(center: center, brushDiameter: brushDiameter)
    }
}