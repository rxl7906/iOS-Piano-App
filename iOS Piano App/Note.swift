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
    let startNote = 60 // Middle C
    
    let time: Double // time in song
    let pitch: Int
    
    var shape: SKSpriteNode?
    
    init(time: Double, pitch: Int) {
        self.time = time
        self.pitch = pitch
    }
    
    func makeShape(scene: GameScene) -> SKSpriteNode {
        self.shape = SKSpriteNode(imageNamed: "Dot")
        
        let scale = scene.size.width / CGFloat(keyCount) / CGFloat((self.shape?.size.width)!)
        self.shape?.setScale(scale)
        
        let screenWidth = scene.size.width,
            laneWidth = Double(screenWidth) / Double(keyCount),
            xIndex = self.pitch - self.startNote,
            xPos = Double(xIndex) * 3.0 / 2.0 * laneWidth,
            yPos = Double(scene.size.height) * 0.9
        
        self.shape?.position = CGPoint(x: xPos, y: yPos)
        
        return self.shape!
    }
}
