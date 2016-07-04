//
//  DabFieldSymbol.swift
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
import CoreGraphics

class DabFieldSymbol: DrawableSymbol
{
    let markLength: CGFloat
    
    override var bezierPath: UIBezierPath
    {
        let path = UIBezierPath()
        
        let columns = Int.random(lowerBound: 3, upperBound: 5)
        let rows = Int.random(lowerBound: 2, upperBound: 4)
        
        let dx: CGFloat = CGFloat(Int.random(lowerBound: Int(1.1*self.brushDiameter), upperBound: Int(2*self.brushDiameter)))
        let dy: CGFloat = CGFloat(Int.random(lowerBound: Int(1.1*self.markLength), upperBound: Int(1.2*self.markLength)))
        
        for row in (-rows / 2)...(rows / 2)
        {
            for column in (-columns / 2)...(columns / 2)
            {
                let center = CGPointMake(self.center.x + dx * CGFloat(column), self.center.y + dy * CGFloat(row)).applyNoise(5)
                
                let segment = (self.markLength - self.brushDiameter) / 2.0
                
                var point = CGPoint(x: center.x, y: center.y - segment)
                path.moveToPoint(point)
                
                point = CGPoint(x: center.x, y: center.y + 2 * segment)
                path.addLineToPoint(point)
            }
        }
        
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

