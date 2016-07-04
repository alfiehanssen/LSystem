//
//  PlantProduction.swift
//  Example-iOS
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