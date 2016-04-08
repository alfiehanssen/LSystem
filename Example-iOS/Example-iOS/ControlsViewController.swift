//
//  ControlsViewController.swift
//  Example-iOS
//
//  Created by Hanssen, Alfie on 4/8/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//

import UIKit
import LSystem

class ControlsViewController: UIViewController
{
    @IBOutlet weak var brushDiameterLabel: UILabel!
    @IBOutlet weak var brushDiameterSlider: UISlider!
    @IBOutlet weak var iterationsLabel: UILabel!
    @IBOutlet weak var iterationsSlider: UISlider!
    @IBOutlet weak var paintButton: UIButton!
    
    @IBOutlet weak var productionView: PaintingProductionView!

    private var brushDiameter: Int
    {
        get
        {
            return Int(round(self.brushDiameterSlider.value))
        }
    }

    private var iterations: Int
    {
        get
        {
            return Int(round(self.iterationsSlider.value))
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.brushDiameterSlider.minimumValue = 10
        self.brushDiameterSlider.maximumValue = 200
        self.brushDiameterSlider.value = self.brushDiameterSlider.minimumValue
        
        self.iterationsSlider.minimumValue = 1
        self.iterationsSlider.maximumValue = 10
        self.iterationsSlider.value = self.iterationsSlider.minimumValue
        
        self.didChangeBrushDiameter(self.brushDiameterSlider)
        self.didChangeIterations(self.iterationsSlider)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ControlsViewController.didTapPainting))
        self.productionView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func didChangeBrushDiameter(sender: UISlider)
    {
        self.brushDiameterLabel.text = "\(self.brushDiameter)"
    }

    @IBAction func didChangeIterations(sender: UISlider)
    {
        self.iterationsLabel.text = "\(self.iterations)"
    }

    @IBAction func didTapPaint(sender: UIButton)
    {
        self.view.userInteractionEnabled = false
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { 

            let canvasSize = self.productionView.frame.size
            let brushDiameter = CGFloat(self.brushDiameter)
            let colorPalette = [UIColor.redColor(), UIColor.blueColor(), UIColor.yellowColor()]
            
            let production = PaintingProduction(canvasSize: canvasSize, brushDiameter: brushDiameter, colorPalette: colorPalette)
            
            production.expand(iterations: self.iterations)
        
            dispatch_async(dispatch_get_main_queue(), { 
                self.productionView.symbols = production.symbols as? [DrawableSymbol]       
        
                self.view.userInteractionEnabled = true
            })
        }
    }
    
    func didTapPainting(sender: UITapGestureRecognizer)
    {
        let view = self.productionView
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, scale)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: false)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: [])
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
