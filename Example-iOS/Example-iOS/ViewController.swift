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
    
        let axiom = Circle()
        
        let production = Production(axiom: [axiom])
        
        production.register(symbolType: Circle.self) { (symbol) -> [Symbol] in
            
            let circle = Circle()
            let square = Square()
            
            return [square, circle]
        }
        
        production.register(symbolType: Square.self) { (symbol) -> [Symbol] in
            
            let circle = Circle()
            
            return [circle, circle]
        }
        
        production.expand(iterations: 2)
        
        production.printSymbols()
    }
    
    class Circle: Symbol
    {
        var diameter = 10
        
        override var description: String
        {
            return String(self.dynamicType)
        }
    }
    
    class Square: Symbol
    {
        var edge = 10

        override var description: String
        {
            return String(self.dynamicType)
        }
    }
}