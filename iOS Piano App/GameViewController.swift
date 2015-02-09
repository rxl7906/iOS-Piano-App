//
//  GameViewController.swift
//  iOS Piano App
//
//  Created by Apple on 2/7/15.
//  Copyright (c) 2015 iOSAppChallengeRIT. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class GameViewController: UIViewController {
    
    var scene: GameScene!
    
    var audioPlayer: AVAudioPlayer? // for audio

    override func viewDidLoad() {
        super.viewDidLoad()

        let skView = view as SKView
        skView.multipleTouchEnabled = true
        
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = SKSceneScaleMode.AspectFill
        
        skView.presentScene(scene)
        
        
        var paths = NSBundle.mainBundle().resourcePath!
        var getImagePath = paths.stringByAppendingPathComponent("Piano.mf.A4.aiff")
        
        var error: NSError? = NSError()
        audioPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: getImagePath), error: &error)
        
        println(error)
        
        audioPlayer!.prepareToPlay()
        audioPlayer!.play()

    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
