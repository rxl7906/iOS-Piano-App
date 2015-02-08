//
//  Note.swift
//  iOS Piano App
//
//  Created by Brian To on 2/7/15.
//  Copyright (c) 2015 iOSAppChallengeRIT. All rights reserved.
//

import SpriteKit

class Note {
    let keyCount = 25 // 2 octaves + 1 note (also in Keyboard.swift)
    
    let time: Float // time in song
    let pitch: Int
    
    var shape: SKSpriteNode?
    
    init(time: Float, pitch: Int) {
        self.time = time
        self.pitch = pitch
    }
    
    func makeShape(scene: GameScene) -> SKSpriteNode {
        self.shape = SKSpriteNode(imageNamed: "Dot")
        
        let scale = scene.size.width / CGFloat(keyCount) / CGFloat((self.shape?.size.width)!)
        
        self.shape?.setScale(scale)
        
        return self.shape!
    }
}
