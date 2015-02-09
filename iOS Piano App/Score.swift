//
//  Score.swift
//  iOS Piano App
//
//  Created by Brian To on 2/8/15.
//  Copyright (c) 2015 iOSAppChallengeRIT. All rights reserved.
//

import SpriteKit
import AVFoundation

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
    
    //var audioPlayer: AVAudioPlayer? // declare audio
    let resourcePath = NSBundle.mainBundle().resourcePath! // looking in the bundle
    
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
            
            var audioPlayer: AVAudioPlayer?
            
            playNote(note)
        }
    }

    func playNote(note: Note) {
        let player = noteDict[note.pitch]
        
        if let p = player {
            if p.playing {
                p.stop()
                p.currentTime = 0
            }
            
            p.play()
        }
    }
    
    func makePlayer(file: String) -> AVAudioPlayer {
        let url = NSURL(fileURLWithPath: resourcePath.stringByAppendingPathComponent(file))
        let player = AVAudioPlayer(contentsOfURL: url, error: nil)
        
        player.prepareToPlay()
        
        return player
    }
    
    lazy var noteDict: [Int: AVAudioPlayer] = {
        return [
        60: self.makePlayer("Piano.mf.C4.aiff"),
        61: self.makePlayer("Piano.mf.Db4.aiff"),
        62: self.makePlayer("Piano.mf.D4.aiff"),
        63: self.makePlayer("Piano.mf.Eb4.aiff"),
        64: self.makePlayer("Piano.mf.E4.aiff"),
        65: self.makePlayer("Piano.mf.F4.aiff"),
        66: self.makePlayer("Piano.mf.Gb4.aiff"),
        67: self.makePlayer("Piano.mf.G4.aiff"),
        68: self.makePlayer("Piano.mf.Ab4.aiff"),
        69: self.makePlayer("Piano.mf.A4.aiff"),
        70: self.makePlayer("Piano.mf.Bb4.aiff"),
        71: self.makePlayer("Piano.mf.B4.aiff"),
        72: self.makePlayer("Piano.mf.C5.aiff"),
        73: self.makePlayer("Piano.mf.Db5.aiff"),
        74: self.makePlayer("Piano.mf.D5.aiff"),
        75: self.makePlayer("Piano.mf.Eb5.aiff"),
        76: self.makePlayer("Piano.mf.E5.aiff"),
        77: self.makePlayer("Piano.mf.F5.aiff"),
        78: self.makePlayer("Piano.mf.Gb5.aiff"),
        79: self.makePlayer("Piano.mf.G5.aiff"),
        80: self.makePlayer("Piano.mf.Ab5.aiff"),
        81: self.makePlayer("Piano.mf.A5.aiff"),
        82: self.makePlayer("Piano.mf.Bb5.aiff"),
        83: self.makePlayer("Piano.mf.B5.aiff")
    ]
    }()
    
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
let C5      = 72
let CSHARP5 = 73
let DFLAT5  = 73
let D5      = 74
let DSHARP5 = 75
let EFLAT5  = 75
let E5      = 76
let F5      = 77
let FSHARP5 = 78
let GFLAT5  = 78
let G5      = 79
let GSHARP5 = 80
let AFLAT5  = 80
let A5      = 81
let ASHARP5 = 82
let BFLAT5  = 82
let B5      = 83

class SampleSong {
    var time = 0.0
    
    lazy var notes: [Note] = {[
        self.note(0.5, pitch: AFLAT5),
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: AFLAT5),
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: AFLAT5),
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: AFLAT5),
        self.note(0.5, pitch: E5),
        
        self.note(0.5, pitch: GFLAT5),
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: GFLAT5),
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: GFLAT5),
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: GFLAT5),
        self.note(0.5, pitch: E5),
        
        self.note(0.5, pitch: AFLAT5),
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: AFLAT5),
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: AFLAT5),
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: AFLAT5),
        self.note(0.5, pitch: E5),
        
        self.note(0.5, pitch: GFLAT5),
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: GFLAT5),
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: GFLAT5),
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: GFLAT5),
        self.note(0.5, pitch: E5),
        
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: GFLAT5),
        self.note(0.5, pitch: AFLAT5),
        
        self.note(0.5, pitch: B4),
        self.note(0.5, pitch: AFLAT5),
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: GFLAT5),
        
        self.note(0.5, pitch: B4),
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: E5),
        
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: GFLAT5),
        self.note(0.5, pitch: AFLAT5),
        self.note(0.5, pitch: E5),
        
        self.note(0.5, pitch: B4),
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: AFLAT5),
        self.note(0.5, pitch: GFLAT5),
        self.note(0.5, pitch: E5),
        
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: GFLAT5),
        self.note(0.5, pitch: AFLAT5),
        
        self.note(0.5, pitch: B4),
        self.note(0.5, pitch: AFLAT5),
        self.note(0.5, pitch: GFLAT5),
        self.note(0.5, pitch: GFLAT5),
        
        self.note(0.5, pitch: B4),
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: E5),
        
        self.note(0.5, pitch: GFLAT5),
        self.note(0.5, pitch: AFLAT5),
        self.note(0.5, pitch: E5),
        
        self.note(0.5, pitch: B4),
        self.note(0.5, pitch: E5),
        self.note(0.5, pitch: AFLAT5),
        self.note(0.5, pitch: GFLAT5),
        self.note(0.5, pitch: E5)
        
        
    ]}()
//        Note(time: 0,   pitch: AFLAT5),
//        Note(time: 0.5, pitch: E5),
//        Note(time: 1.0, pitch: AFLAT5),
//        Note(time: 1.5, pitch: E5),
//        Note(time: 2.0, pitch: AFLAT5),
//        Note(time: 2.5, pitch: E5),
//        Note(time: 3.0, pitch: AFLAT5),
//        Note(time: 3.5, pitch: E5),
//        Note(time: 8.0,   pitch: AFLAT5),
//        Note(time: 9.0, pitch: E5),
//        Note(time: 10.0, pitch: AFLAT5),
//        Note(time: 11.0, pitch: E5),
//        Note(time: 12.0, pitch: AFLAT5),
//        Note(time: 13.0, pitch: E5),
//        Note(time: 14.0, pitch: AFLAT5),
//        Note(time: 15.0, pitch: E5),
//        Note(time: 16.0,   pitch: AFLAT5),
//        Note(time: 17.0, pitch: E5),
//        Note(time: 18.0, pitch: AFLAT5),
//        Note(time: 19.0, pitch: E5),
//        Note(time: 20.0, pitch: AFLAT5),
//        Note(time: 21.0, pitch: E5),
//        Note(time: 22.0, pitch: AFLAT5),
//        Note(time: 23.0, pitch: E5),
//        Note(time: 24.0, pitch: AFLAT5),
//        Note(time: 25.0, pitch: E5),
//        Note(time: 26.0, pitch: AFLAT5),
//        Note(time: 27.0, pitch: E5),
//        Note(time: 28.0, pitch: AFLAT5),
//        Note(time: 29.0, pitch: E5),
//        Note(time: 30.0, pitch: AFLAT5),
//        Note(time: 31.0, pitch: E5),
//        Note(time: 32.0, pitch: AFLAT5),
//        Note(time: 33.0, pitch: E5),
//        Note(time: 34.0, pitch: AFLAT5),
//        Note(time: 35.0, pitch: E5),
//        Note(time: 36.0, pitch: AFLAT5),
//        Note(time: 37.0, pitch: E5),
//        Note(time: 38.0, pitch: AFLAT5),
//        Note(time: 39.0, pitch: E5),
//        Note(time: 40.0, pitch: AFLAT5),
    
    func note(duration: Double, pitch: Int) -> Note {
        let note = Note(time: time, pitch: pitch)
        
        time += duration
        
        return note;
    }
}