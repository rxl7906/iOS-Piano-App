//
//  Score.swift
//  iOS Piano App
//
//  Created by Brian To on 2/8/15.
//  Copyright (c) 2015 iOSAppChallengeRIT. All rights reserved.
//

import SpriteKit

class Score {
    var notes: [Note] = []
    var displayedNotes: [Note] = []
    let timingWindowDuration: Float = 4 // seconds
    let timingOverflowDuration: Float = 0.25 // seconds
    
    var time: Float = -3.0
    
    var scene: GameScene? = nil
    
    init() {
        // Fake instead of reading in real notes
        self.notes = SampleSong().notes
    }
    
    func attach(scene: GameScene) {
        self.scene = scene
        
        self.fillDisplayedNotes()
    }
    
    func update(dt: Float) {
        self.time += dt
        
        self.cleanUpDisplayedNotes()
        self.fillDisplayedNotes()
    }
    
    func fillDisplayedNotes() {
        while self.notes[0].time < self.time + self.timingWindowDuration {
            let note = notes[0]
            
            note.makeShape(self.scene!)
            
            self.notes.removeAtIndex(0)
            self.displayedNotes.append(note)
        }
    }
    
    func cleanUpDisplayedNotes() {
        while self.displayedNotes[0].time < self.time - self.timingOverflowDuration {
            let note = self.displayedNotes.removeAtIndex(0)
            
            if let shape = note.shape {
                shape.removeFromParent()
            }
        }
    }
    
    func moveDisplayedNotes(dt: Float) {
        let delta = CGVector(dx: 0, dy: 0)
        
        // Technically, it's for next duration, but close enough...
//        let action = SKAction.moveBy(delta: delta, duration: dt)
    }
}

let C4      = 60
let CSHARP4 = 61
let DFLAT4  = 61
let D4      = 62
let DSHARP4 = 63
let EFLAT4  = 63
let E4      = 64
let F4      = 65
let FSHARP4 = 66
let GFLAT4  = 66
let G4      = 67
let GSHARP4 = 68
let AFLAT4  = 68
let A4      = 69
let ASHARP4 = 70
let BFLAT4  = 70
let B4      = 71

class SampleSong {
    let notes: [Note] = [
        Note(time: 0,   pitch: C4),
        Note(time: 0.5, pitch: C4),
        Note(time: 1.0, pitch: G4),
        Note(time: 1.5, pitch: G4),
        Note(time: 2.0, pitch: A4),
        Note(time: 2.5, pitch: A4),
        Note(time: 3.0, pitch: G4)
    ]
}