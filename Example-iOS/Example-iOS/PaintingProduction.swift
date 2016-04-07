//
//  PaintingProduction.swift
//  Example-iOS
//
//  Created by Hanssen, Alfie on 4/6/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//

import Foundation
import LSystem

class PaintingProduction: Production
{
    let canvasSize: CGSize
    
    init(canvasSize: CGSize)
    {
        assert(!CGSizeEqualToSize(canvasSize, CGSizeZero), "Canvas size cannot be zero.")
        
        self.canvasSize = canvasSize
        
        let axiom = self.dynamicType.axiom(canvasSize: canvasSize)
        super.init(axiom: axiom)
        
        self.registerTransforms()
    }
    
    private static func axiom(canvasSize canvasSize: CGSize) -> [Symbol]
    {
        let location = canvasSize.centerPoint()
        let segmentLength = canvasSize.height / 3.0
        
        let symbol = XSymbol(location: location, segmentLength: segmentLength)
        
        return [symbol]
    }

    private func registerTransforms()
    {
        self.register(symbolType: XSymbol.self) { (symbol) -> [Symbol] in
            
            let symbol = symbol as! XSymbol
            
            let oLocation = symbol.location.offsetBy(dx: 5, dy: 5)
            let O = OSymbol(location: oLocation, diameter: symbol.segmentLength)
            
            let x1Location = symbol.location.offsetBy(dx: 5, dy: -5)
            let X1 = XSymbol(location: x1Location, segmentLength: symbol.segmentLength * 0.9)
            
            let x2Location = symbol.location.offsetBy(dx: -5, dy: -5)
            let X2 = XSymbol(location: x2Location, segmentLength: symbol.segmentLength * 1.1)
            
            return [O, X1, X2]
        }
        
        self.register(symbolType: OSymbol.self) { (symbol) -> [Symbol] in
            return [symbol]
        }
    }
}

class XSymbol: PathSymbol
{
    let segmentLength: CGFloat
    
    required init(location: CGPoint, segmentLength: CGFloat)
    {
        assert(segmentLength > 0, "Segment length must be greater than zero.")
        
        self.segmentLength = segmentLength
        
        super.init(location: location)
    }
}

class OSymbol: PathSymbol
{
    let diameter: CGFloat

    required init(location: CGPoint, diameter: CGFloat)
    {
        assert(diameter > 0, "Diameter must be greater than zero.")
        
        self.diameter = diameter
        
        super.init(location: location)
    }
}

protocol Drawable
{
    var location: CGPoint { get set }
    
}

class PathSymbol: Symbol, Drawable
{
    var location: CGPoint
    
//    var rotation: CGFloat?
//    var fillColor: UIColor?
//    var markDiameter: CGFloat?
//    var path: UIBezierPath?
    
    init(location: CGPoint)
    {
        self.location = location
    }
    
    func path() -> UIBezierPath
    {
        return UIBezierPath()
    }
}

extension CGSize
{
    func centerPoint() -> CGPoint
    {
        let x = self.width / 2.0
        let y = self.height / 2.0
        
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