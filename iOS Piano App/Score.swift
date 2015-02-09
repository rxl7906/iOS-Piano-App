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
    var deltaPixelsPerSecond: CGFloat = 0
    
    let timingWindowDuration: Double = 4 // seconds
    let timingOverflowDuration: Double = 0.25 // seconds
    
    let bpm = 100 // beats per minute
    let beatsPerMeasure = 4 // 4/4 time
    let measuresPerScren = 2 // Show 2 measures at a time
    let heightRatio: CGFloat = 0.85
    
    var time: Double = -3.0
    
    var scene: GameScene? = nil
    
    init() {
        // Fake instead of reading in real notes
        self.notes = SampleSong().notes
    }
    
    func attach(scene: GameScene) {
        self.scene = scene
        
        // 100 beats    1 min   1 measure   1 screen    200 px     px
        // --------- * ------ * --------- * --------- * -------- = ---
        //   1 min     60 sec   4 beats     2 mesures   1 screen   sec
        self.deltaPixelsPerSecond =
            CGFloat(bpm) *
            CGFloat(1.0 / 60.0) /
            CGFloat(beatsPerMeasure) /
            CGFloat(measuresPerScren) *
            scene.size.height * self.heightRatio
        
        
        self.fillDisplayedNotes()
    }
    
    func update(dt: Double) {
        self.time += dt
        
        self.moveDisplayedNotes(dt)
        self.cleanUpDisplayedNotes()
        self.fillDisplayedNotes()
    }
    
    func fillDisplayedNotes() {
        while !self.notes.isEmpty && self.notes[0].time < self.time + self.timingWindowDuration {
            let note = notes[0]
            
            let shape = note.makeShape(self.scene!)
            
            self.scene?.addChild(shape)
            
            self.notes.removeAtIndex(0)
            self.displayedNotes.append(note)
        }
    }
    
    func cleanUpDisplayedNotes() {
        while !self.displayedNotes.isEmpty && self.displayedNotes[0].time < self.time - self.timingOverflowDuration {
            let note = self.displayedNotes.removeAtIndex(0)
            
            if let shape = note.shape {
                shape.removeFromParent()
            }
        }
    }
    
    func moveDisplayedNotes(dt: Double) {
        // Technically, it's for next duration, but close enough...
        let delta = CGVector(dx: 0, dy: CGFloat(-1) * CGFloat(dt) * self.deltaPixelsPerSecond)
        let action = SKAction.moveBy(delta, duration: NSTimeInterval(0.001)) // duration < dt b/c lol
        
        for note in self.displayedNotes {
            if let shape = note.shape {
                shape.runAction(action)
            }
        }
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