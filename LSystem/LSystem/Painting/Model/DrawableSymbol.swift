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
    let markWidth: CGFloat
    
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
    
    init(center: CGPoint, markWidth: CGFloat)
    {
        self.center = center
        self.markWidth = markWidth
    }
}
