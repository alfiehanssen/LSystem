//
//  Production.swift
//  LSystem
//
//  Created by Hanssen, Alfie on 4/6/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//

import Foundation

public class Production
{
    public let axiom: [Symbol]
    
    public private(set) var symbols: [Symbol]
    public private(set) var transforms = [String: Transform]()
    
    public init(axiom: [Symbol])
    {
        assert(axiom.count > 0, "Axiom count must be greater than zero.")
        
        self.axiom = axiom
        self.symbols = axiom
    }
    
    public func register<T: Symbol>(symbolType symbolType: T.Type, transform: Transform)
    {
        let name = String(T)
        self.transforms[name] = transform
    }
    
    public func expand(iterations iterations: Int)
    {
        assert(iterations > 0, "Iterations must be greater than zero.")
        assert(self.transforms.count > 0, "Transforms count must be greater than zero.")
        
        var iterations = iterations

        while iterations > 0
        {
            self.expand()
            
            iterations -= 1
        }
    }
    
    public func expand()
    {
        var newSymbols = [Symbol]()
        
        for symbol in self.symbols
        {
            let name = String(symbol.dynamicType)
            if let transform = self.transforms[name]
            {
                let result = transform(symbol: symbol)
                newSymbols.appendContentsOf(result)
            }
            else
            {
                newSymbols.append(symbol)
            }
        }
        
        self.symbols = newSymbols
    }
    
    public func reset()
    {
        self.symbols = self.axiom
    }
}