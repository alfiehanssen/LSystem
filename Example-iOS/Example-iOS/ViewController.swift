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
    
        let production = PlantProduction()
        
        production.expand(iterations: 2)
        
        print(production.symbols)
    }    
}