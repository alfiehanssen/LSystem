//
//  CGGeometry+Extensions.swift
//  Example-iOS
//
//  Created by Hanssen, Alfie on 4/7/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGSize
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
        let y = CGFloat(arc4random_uniform(UInt32(self.width)))

        return CGPointMake(x, y)
    }
}

extension CGPoint
{
    func offsetBy(dx dx: CGFloat, dy: CGFloat) -> CGPoint
    {
        let x = self.x + dx
        let y = self.y + dy
        
        return CGPointMake(x, y)
    }
}

extension CGFloat
{
    func radians() -> CGFloat
    {
        return self * CGFloat(M_PI) / 180.0
    }
}