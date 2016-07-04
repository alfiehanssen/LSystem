//
//  SquiggleSymbol.swift
//  LSystem
//
//  Created by Hanssen, Alfie on 4/8/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

class SquiggleSymbol: DrawableSymbol
{
    let markLength: CGFloat
    
    override var bezierPath: UIBezierPath
    {
        let path = UIBezierPath()
        
        let segment = (self.markLength - self.brushDiameter) / 2.0
        
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

        path.lineWidth = self.brushDiameter
        path.lineCapStyle = .Round
        
        return path
    }
    
    init(center: CGPoint, brushDiameter: CGFloat, markLength: CGFloat)
    {
        assert(markLength > 0, "Mark length must be greater than 0.")

        self.markLength = markLength
        
        super.init(center: center, brushDiameter: brushDiameter)
    }
}
