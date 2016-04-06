//
//  Production.swift
//  LSystem
//
//  Created by Hanssen, Alfie on 4/6/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//

import Foundation

class Production
{
    let axiom: [Symbol]
    
    private(set) var symbols: [Symbol]
    private(set) var transforms: [String: Transform]
    
    init(axiom: [Symbol])
    {
        self.axiom = axiom
        self.symbols = axiom
        self.transforms = [:]
    }
    
    func register<T: Symbol>(symbolType symbolType: T.Type, transform: Transform)
    {
        let name = String(T)
        self.transforms[name] = transform
    }
    
    func expand(iterations iterations: Int)
    {
        assert(iterations > 0, "Iterations must be greater than zero.")
        
        var iterations = iterations
        
        while iterations > 0
        {
            self.expand()
            
            iterations -= 1
        }
    }
    
    func expand()
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
    
    func printSymbols()
    {
        print(self.symbols)
    }
}