//
//  ViewController.swift
//  Example-iOS
//
//  Created by Hanssen, Alfie on 4/6/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//

import UIKit
import LSystem

class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        let x = X()
        let axiom = [x]
        
        let production = Production(axiom: axiom)
        
        production.register(symbolType: X.self) { (symbol) -> [Symbol] in
            
            let x = X()
            let f = F()
            let minus = Minus()
            let plus = Plus()
            let left = Left()
            let right = Right()
            
            return [f, minus, left, left, x, right, plus, x, right, plus, f, left, plus, f, x, right, minus, x]
        }
        
        production.register(symbolType: F.self) { (symbol) -> [Symbol] in
            
            let f = F()
            
            return [f, f]
        }
        
        production.expand(iterations: 1)
        
        print(production.symbols)
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
}