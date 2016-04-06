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
    init()
    {
        let x = XSymbol()
        let axiom = [x]
        
        super.init(axiom: axiom)
        
        self.registerTransforms()
    }
    
    private func registerTransforms()
    {
        self.register(symbolType: XSymbol.self) { (symbol) -> [Symbol] in
            return []
        }
        
        self.register(symbolType: OSymbol.self) { (symbol) -> [Symbol] in
            return []
        }
    }
}

class PathSymbol: Symbol
{
    var offset: CGPoint?
    var rotation: CGFloat?
    var fillColor: UIColor?
    var markDiameter: CGFloat?
    var path: UIBezierPath?
}

class XSymbol: PathSymbol
{
    let segmentLength = 10
}

class OSymbol: PathSymbol
{
    let diameter = 10
}
