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
    @IBOutlet weak var productionView: PaintingProductionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        let canvasSize = self.view.frame.size
        let brushDiameter: CGFloat = 60
        let colorPalette = [UIColor.redColor(), UIColor.blueColor(), UIColor.yellowColor()]
        let production = PaintingProduction(canvasSize: canvasSize, brushDiameter: brushDiameter, colorPalette: colorPalette)
        
        production.expand(iterations: 10)

        self.productionView.symbols = production.symbols as? [DrawableSymbol]
    }
}