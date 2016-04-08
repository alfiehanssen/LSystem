//
//  CGGeometry+Extensions.swift
//  Example-iOS
//
//  Created by Hanssen, Alfie on 4/7/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
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
    func offsetBy(dx dx: CGFloat, dy: CGFloat) -> CGPoint
    {
        let x = self.x + dx
        let y = self.y + dy
        
        return CGPointMake(x, y)
    }
}

public extension CGFloat
{
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

    static func random(lowerBound lowerBound: Int, upperBound: Int) -> Int
    {
        let size = UInt32(upperBound)
        
        return Int(arc4random_uniform(size)) + lowerBound
    }
}