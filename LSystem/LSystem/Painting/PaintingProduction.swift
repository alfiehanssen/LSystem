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
        let center = canvasSize.randomPoint()
        let brushDiameter = brushDiameter
        let markLength: CGFloat = canvasSize.height / 3.0
        
        let symbol = XSymbol(center: center, brushDiameter: brushDiameter, markLength: markLength)
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
            let O = OSymbol(center: center, brushDiameter: self.brushDiameter, diameter: diameter)
            O.strokeColor = self.colorPalette[index]
            
            center = self.canvasSize.randomPoint()
            index = Int.random(upperBound: self.colorPalette.count)
            
            let squiggle = SquiggleSymbol(center: center, brushDiameter: self.brushDiameter, markLength: symbol.markLength)
            squiggle.strokeColor = self.colorPalette[index]
            squiggle.noise = 0.5
            
            return [O, symbol, squiggle]
        }
        
        // Replace O with a dab field, sometimes
        self.register(symbolType: OSymbol.self) { (symbol) -> [Symbol] in

            var symbols = [Symbol]()
            
            let random = CGFloat.randomZeroToOne()
            if random < 0.75
            {
                let index = Int.random(upperBound: self.colorPalette.count)
                let color = self.colorPalette[index]
                let rotation = CGFloat(Int.random(upperBound: 360))
                
                let markLength = CGFloat(Int.random(lowerBound: Int(1.5*self.brushDiameter), upperBound: Int(3*self.brushDiameter)))

                let dabField = DabFieldSymbol(center: self.canvasSize.randomPoint(), brushDiameter: self.brushDiameter, markLength: markLength)
                dabField.strokeColor = color
                dabField.rotation = rotation
                
                symbols.append(dabField)
            }

            symbols.append(symbol)
            
            return symbols
        }
        
        // Add a squiggle next to a squiggle
        self.register(symbolType: SquiggleSymbol.self) { (symbol) -> [Symbol] in
            
            let symbol = symbol as! SquiggleSymbol

            let squiggle = SquiggleSymbol(center: symbol.center.applyNoise(40), brushDiameter: self.brushDiameter, markLength: symbol.markLength)
            squiggle.strokeColor = symbol.strokeColor
            squiggle.noise = 0.5
            squiggle.blendMode = .Difference

            return [symbol, squiggle]
        }
    }
}