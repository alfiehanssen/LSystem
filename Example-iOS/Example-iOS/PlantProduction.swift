//
//  PlantProduction.swift
//  Example-iOS
//
//  Created by Hanssen, Alfie on 4/6/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//

import Foundation
import LSystem

class PlantProduction: Production
{
    init()
    {
        let x = X()
        let axiom = [x]
        
        super.init(axiom: axiom)

        self.registerTransforms()
    }
    
    private func registerTransforms()
    {
        self.register(symbolType: X.self) { (symbol) -> [Symbol] in
            
            let x = X()
            let f = F()
            let minus = Minus()
            let plus = Plus()
            let left = Left()
            let right = Right()
            
            return [f, minus, left, left, x, right, plus, x, right, plus, f, left, plus, f, x, right, minus, x]
        }
        
        self.register(symbolType: F.self) { (symbol) -> [Symbol] in
            
            let f = F()
            
            return [f, f]
        }
    }
}

class X: Symbol
{
    
}

class F: Symbol
{
    
}

class Minus: Symbol
{
    
}

class Plus: Symbol
{
    
}

class Left: Symbol
{
    
}

class Right: Symbol
{
    
}