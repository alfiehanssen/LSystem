//
//  CGGeometry+Extensions.swift
//  Example-iOS
//
//  Created by Hanssen, Alfie on 4/7/16.
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

import Foundation
import CoreGraphics

public extension CGSize
{
    func centerPoint() -> CGPoint
    {
        let x = self.width / 2.0
        let y = self.height / 2.0
        
        return CGPointMake(x, y)
    }
    
    func randomPoint() -> CGPoint
    {
        // TODO: does this need to be seeded?
        
        let x = CGFloat(arc4random_uniform(UInt32(self.width)))
        let y = CGFloat(arc4random_uniform(UInt32(self.height)))

        return CGPointMake(x, y)
    }
}

public extension CGPoint
{
    func applyNoise(noise: CGFloat) -> CGPoint
    {
        let noise = Int(noise)

        let xSign = Int.randomSign()
        let dx = CGFloat(xSign * Int.random(upperBound: noise))
        
        let ySign = Int.randomSign()
        let dy = CGFloat(ySign * Int.random(upperBound: noise))

        return self.offsetBy(dx: dx, dy: dy)
    }
    
    func offsetBy(dx dx: CGFloat, dy: CGFloat) -> CGPoint
    {
        let x = self.x + dx
        let y = self.y + dy
        
        return CGPointMake(x, y)
    }
}

public extension CGFloat
{
    func applyNoise(noise: Int) -> CGFloat // TODO: fix this wrt bounds
    {
        let sign = Int.randomSign()
        let d = CGFloat(sign * Int.random(upperBound: noise))
        
        return self + d
    }

    func radians() -> CGFloat
    {
        return self * CGFloat(M_PI) / 180.0
    }
    
    static func randomZeroToOne() -> CGFloat
    {
        return CGFloat(drand48())
    }
}

public extension Int
{
    static func random(upperBound upperBound: Int) -> Int
    {
        return Int.random(lowerBound: 0, upperBound: upperBound)
    }

    static func randomSign() -> Int
    {
        return (arc4random() % 2 == 1 ? 1 : -1)
    }

    static func random(lowerBound lowerBound: Int, upperBound: Int) -> Int
    {
        let size = UInt32(upperBound)
        
        return Int(arc4random_uniform(size)) + lowerBound
    }
}