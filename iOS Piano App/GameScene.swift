//
//  GameScene.swift
//  iOS Piano App
//
//  Created by Apple on 2/7/15.
//  Copyright (c) 2015 iOSAppChallengeRIT. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var keyboard: Keyboard? = nil
    var score: Score? = nil
    
    var last: NSTimeInterval? = nil
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        /* myLabel.text = "Hello, World!"; */
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
    }
    
    func flashNote(note: Note) {
        if let kbd = self.keyboard {
            kbd.flashNote(note)
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
    }
    
    override func update(currentTime: CFTimeInterval) {
        if let myLast = last {
            let delta = currentTime - myLast
            
            self.score?.update(delta)
            
            self.keyboard?.clearFlash(delta)
            
            self.last = currentTime
        } else {
            last = currentTime
        }
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        keyboard = Keyboard()
        keyboard?.attach(self)
        
        score = Score()
        score?.attach(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
