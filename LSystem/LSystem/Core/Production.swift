//
//  Production.swift
//  LSystem
//
//  Created by Hanssen, Alfie on 4/6/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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