//
//  PaintingProductionView.swift
//  Example-iOS
//
//  Created by Hanssen, Alfie on 4/7/16.
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

import UIKit
import CoreGraphics

public class PaintingProductionView: UIView
{
    public var symbols: [DrawableSymbol]?
    {
        didSet
        {
            self.setNeedsDisplay()
        }
    }
    
    public override func drawRect(rect: CGRect)
    {
        guard let symbols = self.symbols else
        {
            return
        }
                
        for symbol in symbols
        {
            let path = symbol.bezierPath
            
            let radians = symbol.rotation.radians()
            let transform = CGAffineTransformMakeRotation(radians);
            path.applyTransform(transform)

            if let fillColor = symbol.fillColor
            {
                fillColor.setFill()
                path.fillWithBlendMode(symbol.blendMode, alpha: symbol.alpha)
            }
            
            if let strokeColor = symbol.strokeColor
            {
                strokeColor.setStroke()
                path.strokeWithBlendMode(symbol.blendMode, alpha: symbol.alpha)
            }
        }
    }
}
