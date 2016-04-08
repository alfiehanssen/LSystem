//
//  VideoViewController.swift
//  GIFSet-Example
//
//  Created by Alfred Hanssen on 3/27/16.
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
import VIMVideoPlayer

protocol Dismissable: class
{
    func requestDismissal(viewController viewController: UIViewController, animated: Bool)
}

class VideoViewController: UIViewController, VIMVideoPlayerViewDelegate
{
    var videoURL: NSURL!
    var imageURL: NSURL!
    
    weak var delegate: Dismissable?
    
    // MARK: IBOUtlets
    
    @IBOutlet weak var videoPlayerView: VIMVideoPlayerView!

    // MARK: View Lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.setupVideoPlayerView()
    }
    
    // MARK: VIMVideoPlayerViewDelegate
    
    func videoPlayerViewIsReadyToPlayVideo(videoPlayerView: VIMVideoPlayerView?)
    {
        self.videoPlayerView.player.play()
    }

    // MARK: Setup
    
    private func setupVideoPlayerView()
    {
        let asset = AVURLAsset(URL: self.videoURL)
        
        self.videoPlayerView.player.looping = true
        self.videoPlayerView.player.disableAirplay()
        self.videoPlayerView.setVideoFillMode(AVLayerVideoGravityResizeAspect)
        self.videoPlayerView.delegate = self
        self.videoPlayerView.player.setAsset(asset)
    }

    // MARK: Actions
    
    @IBAction func didTapSharePainting(sender: UIButton)
    {
        let path = self.imageURL.path!
        let image = UIImage(contentsOfFile: path)!
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: [])
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }

    @IBAction func didTapShareVideo(sender: UIButton)
    {
        let activityViewController = UIActivityViewController(activityItems: [self.videoURL], applicationActivities: [])
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }

    @IBAction func didTapDismiss(sender: UIButton)
    {
        self.delegate?.requestDismissal(viewController: self, animated: true)
    }
}
