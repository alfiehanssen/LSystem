//
//  PaintingProductionView.swift
//  Example-iOS
//
//  Created by Hanssen, Alfie on 4/7/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//

import UIKit

class PaintingProductionView: UIView
{
    var symbols: [PathSymbol]?
    {
        didSet
        {
            self.setNeedsDisplay()
        }
    }
    
    override class func layerClass() -> AnyClass
    {
        return CAShapeLayer.self
    }
    
    override func drawRect(rect: CGRect)
    {
        guard let symbols = self.symbols else
        {
            return
        }

        print(symbols)
        
        for symbol in symbols
        {
            
        }
    }
}
