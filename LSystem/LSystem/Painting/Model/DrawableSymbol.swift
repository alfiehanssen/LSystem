//
//  DrawableSymbol.swift
//  LSystem
//
//  Created by Hanssen, Alfie on 4/8/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//

import CoreGraphics
import UIKit

public class DrawableSymbol: Symbol
{
    let center: CGPoint
    let brushDiameter: CGFloat
    
    var noise: CGFloat = 0
    var alpha: CGFloat = 1
    var blendMode: CGBlendMode = .Normal
    var rotation: CGFloat = 0
    
    var fillColor: UIColor?
    var strokeColor: UIColor?
    
    var bezierPath: UIBezierPath
    {
        assertionFailure("Subclasses must override bezierPath")
        
        return UIBezierPath()
    }
    
    init(center: CGPoint, brushDiameter: CGFloat)
    {
        assert(brushDiameter > 0, "Brush diameter must be greater than 0.")

        self.center = center
        self.brushDiameter = brushDiameter
    }
}
