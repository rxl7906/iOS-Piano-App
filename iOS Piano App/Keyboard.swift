//
//  Keyboard.swift
//  iOS Piano App
//
//  Created by Brian To on 2/7/15.
//  Copyright (c) 2015 iOSAppChallengeRIT. All rights reserved.
//

import SpriteKit

class Keyboard {
    let keyCount = 25 // 2 octaves + 1 note
    let startNote = 60 // Middle C
    let halfTones = [1, 3, 6, 8, 10]
    
    var screenWidth: CGFloat = 0
    var keyWidth: CGFloat = 0
    var keyHeight: CGFloat = 0
    var keyYPos: CGFloat = 0
    
    let keys: [Key] = []
    
    var scene: SKScene?
    
    init() {
        for keyValue in startNote...(startNote + keyCount) {
            keys.append(Key(value: keyValue))
        }
    }
    
    func makeShape(key: Key, scene: SKScene) -> SKShapeNode {
        let xpos = CGFloat(keyIndex(key)) * CGFloat(keyWidth) + (CGFloat(keyWidth) / 2)
        let rect = CGRect(x: xpos, y: keyYPos, width: keyWidth, height: keyHeight)
        let shape = SKShapeNode(rect: rect)
        
        shape.fillColor = keyColor(key)
        
        return shape
    }
    
    func keyIndex(key: Key) -> Int {
        return key.value - startNote
    }
    
    func keyColor(key: Key) -> UIColor {
        if contains(halfTones, key.value % 12) {
            return UIColor.blackColor()
        }
        
        return UIColor.whiteColor()
    }
    
    func attach(scene: SKScene) {
        self.scene = scene
        
        self.screenWidth = scene.size.width
        self.keyWidth = screenWidth / CGFloat(keyCount)
        self.keyHeight = CGFloat(0.15) * scene.size.height
        self.keyYPos = keyHeight / CGFloat(2)
    }
}

class Key {
    let value: Int
    
    init(value: Int) {
        self.value = value
    }
}