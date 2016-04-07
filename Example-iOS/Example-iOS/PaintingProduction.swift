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
        // TODO: This doesn't look like it's starting in the center, should be random anyway
        
        let center = canvasSize.randomPoint()
        let markWidth: CGFloat = 40
        let markLength: CGFloat = canvasSize.height / 3.0
        
        let symbol = XSymbol(center: center, markWidth: markWidth, markLength: markLength)
        
        return [symbol]
    }

    private func registerTransforms()
    {
        self.register(symbolType: XSymbol.self) { (symbol) -> [Symbol] in
            
            let symbol = symbol as! XSymbol
            
            // TODO: Vary location
            // TODO: add noise to mark paths
            // TODO: add dab symbol
            // TODO: New rules, how to decide mark placement with respect to previous mark placements?
            // TODO: keep center points within bounds, roughly
            
            let oCenter = self.canvasSize.randomPoint()
            let O = OSymbol(center: oCenter, markWidth: symbol.markWidth, diameter: 100)
            O.strokeColor = UIColor.purpleColor()
            O.alpha = CGFloat(drand48())
            O.blendMode = .Difference
            
            let x1Center = self.canvasSize.randomPoint()
            let X1 = XSymbol(center: x1Center, markWidth: symbol.markWidth, markLength: symbol.markLength)
            X1.strokeColor = UIColor.redColor()
            X1.alpha = CGFloat(drand48())
            
            let x2Center = self.canvasSize.randomPoint()
            let X2 = XSymbol(center: x2Center, markWidth: symbol.markWidth, markLength: symbol.markLength)
            X2.strokeColor = UIColor.grayColor()
            X2.alpha = CGFloat(drand48())
            X2.blendMode = .HardLight
            
            return [O, X1, X2]
        }
        
        self.register(symbolType: OSymbol.self) { (symbol) -> [Symbol] in
            return [symbol]
        }
    }
}