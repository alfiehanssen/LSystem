//
//  PaintingProduction.swift
//  Example-iOS
//
//  Created by Hanssen, Alfie on 4/6/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

public class PaintingProduction: Production
{
    let canvasSize: CGSize
    let brushDiameter: CGFloat
    let colorPalette: [UIColor]
    
    public init(canvasSize: CGSize, brushDiameter: CGFloat, colorPalette: [UIColor])
    {
        assert(!CGSizeEqualToSize(canvasSize, CGSizeZero), "Canvas size cannot be zero.")
        assert(brushDiameter > 0, "Brush diameter cannot be zero.")
     
        srand48(Int(arc4random()))
        
        self.canvasSize = canvasSize
        self.brushDiameter = brushDiameter
        self.colorPalette = colorPalette
        
        let axiom = self.dynamicType.axiom(canvasSize: canvasSize, brushDiameter: brushDiameter, colorPalette: colorPalette)
        super.init(axiom: axiom)
        
        self.registerTransforms()
    }
    
    private static func axiom(canvasSize canvasSize: CGSize, brushDiameter: CGFloat, colorPalette: [UIColor]) -> [Symbol]
    {
        // TODO: This doesn't look like it's starting in the center, should be random anyway
        
        let center = canvasSize.randomPoint()
        let markWidth = brushDiameter
        let markLength: CGFloat = canvasSize.height / 3.0
        
        let symbol = XSymbol(center: center, markWidth: markWidth, markLength: markLength)
        symbol.strokeColor = colorPalette.first
        
        return [symbol]
    }

    private func registerTransforms()
    {
        self.register(symbolType: XSymbol.self) { (symbol) -> [Symbol] in
            
            let symbol = symbol as! XSymbol
            
            var center = self.canvasSize.randomPoint()
            var index = Int.random(upperBound: self.colorPalette.count)

            let diameter = CGFloat(Int.random(lowerBound: 90, upperBound: 110))
            let O = OSymbol(center: center, markWidth: self.brushDiameter, diameter: diameter)
            O.strokeColor = self.colorPalette[index]
            
            center = self.canvasSize.randomPoint()
            index = Int.random(upperBound: self.colorPalette.count)
            
            let X = XSymbol(center: center, markWidth: self.brushDiameter, markLength: symbol.markLength)
            X.strokeColor = self.colorPalette[index]
            
            center = self.canvasSize.randomPoint()
            index = Int.random(upperBound: self.colorPalette.count)
            
            let squiggle = SquiggleSymbol(center: center, markWidth: self.brushDiameter, markLength: symbol.markLength)
            squiggle.strokeColor = self.colorPalette[index]
            squiggle.noise = 0.5
            
            return [O, X, squiggle]
        }
        
        self.register(symbolType: OSymbol.self) { (symbol) -> [Symbol] in

            var symbols = [Symbol]()
            
            let random = CGFloat.randomZeroToOne()
            if random < 0.35
            {
                let columns = Int.random(lowerBound: 3, upperBound: 5)
                let rows = Int.random(lowerBound: 2, upperBound: 4)

                let index = Int.random(upperBound: self.colorPalette.count)
                let color = self.colorPalette[index]
                let rotation = CGFloat(Int.random(upperBound: 360))
                
                let markLength = CGFloat(Int.random(lowerBound: Int(1.5*self.brushDiameter), upperBound: Int(3*self.brushDiameter)))

                let startPoint = self.canvasSize.randomPoint()
                let dx: CGFloat = CGFloat(Int.random(lowerBound: Int(1.1*self.brushDiameter), upperBound: Int(2*self.brushDiameter)))
                let dy: CGFloat = CGFloat(Int.random(lowerBound: Int(1.1*markLength), upperBound: Int(1.2*markLength)))
                
                for row in (-rows / 2)...(rows / 2)
                {
                    for column in (-columns / 2)...(columns / 2)
                    {
                        let center = CGPointMake(startPoint.x + dx * CGFloat(column), startPoint.y + dy * CGFloat(row)).applyNoise(5)

                        let dab = DabSymbol(center: center, markWidth: self.brushDiameter, markLength: markLength.applyNoise(10))
                        dab.strokeColor = color
                        dab.rotation = rotation
                        
                        symbols.append(dab)
                    }
                }
            }
            
            return symbols
        }
    }
}