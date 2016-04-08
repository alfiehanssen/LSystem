//
//  ControlsViewController.swift
//  Example-iOS
//
//  Created by Hanssen, Alfie on 4/8/16.
//  Copyright © 2016 Alfie Hanssen. All rights reserved.
//

import UIKit
import LSystem
import GIFSet

class ControlsViewController: UIViewController, Dismissable
{
    @IBOutlet weak var brushDiameterLabel: UILabel!
    @IBOutlet weak var brushDiameterSlider: UISlider!
    @IBOutlet weak var iterationsLabel: UILabel!
    @IBOutlet weak var productionView: PaintingProductionView!

    var production: PaintingProduction?
    var imageURLs = [NSURL]()
    let operationQueue = NSOperationQueue()
    
    private var brushDiameter: Int
    {
        get
        {
            return Int(round(self.brushDiameterSlider.value))
        }
    }

    // MARK: View Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.setupSliders()
        self.setupGesture()
    }
    
    // MARK: Setup
    
    private func setupSliders()
    {
        self.brushDiameterSlider.minimumValue = 1
        self.brushDiameterSlider.maximumValue = 100
        self.brushDiameterSlider.value = self.brushDiameterSlider.minimumValue
        
        self.didChangeBrushDiameter(self.brushDiameterSlider)
    }
    
    private func setupGesture()
    {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(ControlsViewController.didTapPainting))
        self.productionView.addGestureRecognizer(singleTap)
    }
    
    private func setupProduction()
    {
        let canvasSize = self.productionView.frame.size
        let brushDiameter = CGFloat(self.brushDiameter)
        let colorPalette = [UIColor.redColor(), UIColor.blueColor(), UIColor.yellowColor(), UIColor.whiteColor()]
        
        self.production = PaintingProduction(canvasSize: canvasSize, brushDiameter: brushDiameter, colorPalette: colorPalette)
    }
    
    // MARK: Actions
    
    @IBAction func didChangeBrushDiameter(sender: UISlider)
    {
        self.brushDiameterLabel.text = "\(self.brushDiameter)"
    }

    @IBAction func didTapClear(sender: UIButton)
    {
        self.imageURLs.removeAll()
        
        self.production?.reset()
        self.production = nil
        
        self.productionView.symbols = []
    }
    
    @IBAction func didTapPaint(sender: UIButton)
    {
        if self.production == nil
        {
            self.setupProduction()
        }
        
        let production = self.production!

        self.view.userInteractionEnabled = false
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { 

            production.expand()
        
            dispatch_async(dispatch_get_main_queue(), { 
        
                self.productionView.symbols = production.symbols as? [DrawableSymbol]
        
                self.saveCurrentImage()
                
                self.view.userInteractionEnabled = true
            })
        }
    }
    
    // MARK: Gestures
    
    func didTapPainting(sender: UITapGestureRecognizer)
    {
        let outputURL = NSURL.uniqueMp4URL()
        let operation = ImageConcatenationOperation(imageURLs: self.imageURLs, duration: 3, outputURL: outputURL)
        operation!.completionBlock = {
            
            dispatch_async(dispatch_get_main_queue(), { 

                let viewController = VideoViewController(nibName: "VideoViewController", bundle: NSBundle.mainBundle())
                viewController.videoURL = outputURL
                viewController.imageURL = self.imageURLs.last
                viewController.delegate = self
                
                self.presentViewController(viewController, animated: true, completion: nil)

            })
        }
        
        self.operationQueue.addOperation(operation!)
    }
    
    // MARK: Private API
    
    private func saveCurrentImage()
    {
        let image = self.getCurrentImage()
        guard let data = UIImagePNGRepresentation(image) else
        {
            assertionFailure("Unable to get data from image.")
            
            return
        }
        
        let URL = NSURL.uniqueImageURL()
        let success = data.writeToFile(URL.absoluteString, atomically: true)
        if !success
        {
            assertionFailure("Unable to write image data to disk.")
            
            return
        }
        
        self.imageURLs.append(URL)
    }
    
    private func getCurrentImage() -> UIImage
    {
        let view = self.productionView
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, scale)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: false)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
    
    // MARK: Dismissable
    
    func requestDismissal(viewController viewController: UIViewController, animated: Bool)
    {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
