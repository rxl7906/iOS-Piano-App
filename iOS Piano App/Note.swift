//
//  Note.swift
//  iOS Piano App
//
//  Created by Brian To on 2/7/15.
//  Copyright (c) 2015 iOSAppChallengeRIT. All rights reserved.
//

import SpriteKit

let noteShapeID: UInt32 = 0x1 << 0
let keyboardKeyShapeID: UInt32 = 0x1 << 1

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
            xPos = Double(xIndex) * laneWidth + 0.5 * laneWidth,
            yPos = Double(scene.size.height) * 0.9
        
        self.shape?.position = CGPoint(x: xPos, y: yPos)
        
        let label = makeLabel(laneWidth)
        
        self.shape?.addChild(label)
        
        return self.shape!
    }
    
    func makeLabel(height: Double) -> SKLabelNode {
        let label = SKLabelNode(text: noteName())
        label.fontColor = UIColor.redColor()
        label.fontName = "ChalkboardSE-Bold"
        label.position = CGPoint(x: 0, y: -1.2 * height)
        label.setScale(3)
        
        return label
    }
    
    let noteNames = ["C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb"]
    
    func noteName() -> String {
        return noteNames[self.pitch % 12]
    }
}
