//
//  Keyboard.swift
//  iOS Piano App
//
//  Created by Brian To on 2/7/15.
//  Copyright (c) 2015 iOSAppChallengeRIT. All rights reserved.
//

import SpriteKit

class Keyboard {
    let keyCount = 37 // 2 octaves + 1 note
    let startNote = 60 // Middle C
    
    let strokeColor = UIColor.grayColor()
    let heightRatio: CGFloat = 0.15
    
    var screenWidth: CGFloat = 0
    var keyWidth: CGFloat = 0
    var keyHeight: CGFloat = 0
    
    let keys: [Key] = []
    
    var scene: SKScene?
    
    init() {
        for keyValue in startNote...(startNote + keyCount) {
            keys.append(Key(value: keyValue))
        }
    }
    
    func makeShape(key: Key, scene: GameScene) -> SKShapeNode {
        let xpos = CGFloat(keyIndex(key)) * CGFloat(keyWidth)
        let rect = CGRect(x: xpos, y: 0, width: keyWidth, height: keyHeight)
        let shape = SKShapeNode(rect: rect)
        
        shape.fillColor = key.color()
        shape.strokeColor = strokeColor
        
        key.shape = shape
        
        return shape
    }
    
    func keyIndex(key: Key) -> Int {
        return key.value - startNote
    }
    
    func attach(scene: GameScene) {
        self.scene = scene
        
        self.screenWidth = scene.size.width
        self.keyWidth = screenWidth / CGFloat(keyCount)
        self.keyHeight = heightRatio * scene.size.height
        
        for key in keys {
            var shape = makeShape(key, scene: scene)
            self.scene?.addChild(shape)
        }
    }
}

class Key {
    let halfTones = [1, 3, 6, 8, 10]

    let value: Int
    var shape: SKShapeNode?
    
    init(value: Int) {
        self.value = value
    }
    
    func isHalfTone() -> Bool {
        return contains(halfTones, self.value % 12)
    }
    
    func color() -> UIColor {
        if isHalfTone() {
            return UIColor.blackColor()
        }
        
        return UIColor.whiteColor()
    }
}