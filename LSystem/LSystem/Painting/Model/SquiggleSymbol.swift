//
//  SquiggleSymbol.swift
//  LSystem
//
//  Created by Hanssen, Alfie on 4/8/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//

import UIKit

class SquiggleSymbol: DrawableSymbol
{
    let markLength: CGFloat
    
    override var bezierPath: UIBezierPath
    {
        let path = UIBezierPath()
        
        let segment = (self.markLength - self.markWidth) / 2.0
        
        let noiseMax = self.markLength
        let dNoise = self.noise * noiseMax
        var point = self.center.offsetBy(dx: -segment, dy: -segment).applyNoise(dNoise)
        path.moveToPoint(point)
        
        var controlPoint1 = self.center.offsetBy(dx: -segment/2.0, dy: -segment/2.0).applyNoise(dNoise)
        var controlPoint2 = self.center.offsetBy(dx: -segment/2.0, dy: -segment/2.0).applyNoise(dNoise)
        path.addCurveToPoint(self.center.applyNoise(dNoise), controlPoint1: controlPoint1, controlPoint2: controlPoint2)

        point = self.center.offsetBy(dx: segment, dy: segment).applyNoise(dNoise)
        controlPoint1 = self.center.offsetBy(dx: segment/2.0, dy: segment/2.0).applyNoise(dNoise)
        controlPoint2 = self.center.offsetBy(dx: segment/2.0, dy: segment/2.0).applyNoise(dNoise)
        path.addCurveToPoint(point, controlPoint1: controlPoint1, controlPoint2: controlPoint2)

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
