//
//  stats.swift
//  Learning
//
//  Created by Kevin Zhang on 7/5/17.
//  Copyright © 2017 Kevin Zhang. All rights reserved.
//

import Foundation
import SpriteKit
import AudioToolbox

class instructions: SKScene {
    
    private var playNode = SKNode()
    private var back = SKSpriteNode(imageNamed: "back_button")
    private var back_touch = false
    
    private var text1 = SKLabelNode(text: "Welcome to Squares!")
    
    private var text2 = SKLabelNode(text: "This is a game based on the")
    private var text3 = SKLabelNode(text: "n_back memory test.")
    
    private var text4 = SKLabelNode(text: "At every round, one square")
    private var text5 = SKLabelNode(text: "will be lit. To proceed to")
    private var text6 = SKLabelNode(text: "the next round, you must")
    private var text7 = SKLabelNode(text: "select the square that was")
    private var text8 = SKLabelNode(text: "lit n turns ago.")
    
    private var text9 = SKLabelNode(text: "n will be 2, 3, or 4")
    private var text10 = SKLabelNode(text: "based on your difficulty.")
    
    private var cont = SKLabelNode(text: "Tap to continue")
    private var should_disappear = false
    
    private var audioNode = SKNode()
    private var sfx : [SKAction] = [SKAction]()
    private var note = 0
    
    private var simNode = SKNode()
    private var arraySquares : [SKSpriteNode] = [SKSpriteNode]()
    private var arrayFrames : [SKSpriteNode] = [SKSpriteNode]()
    private var arrayLabels : [SKLabelNode] = [SKLabelNode]()
    private var arrayPositions : [Int] = [Int]()
    private var arrayMoved = [Bool]()
    private var cur = 0
    private var compare = 0
    private var score2 = 0
    private var orig_alpha = CGFloat(0.0)
    private var orig_alpha_label = CGFloat(0.0)
    private var orig_alpha_frame = CGFloat(0.0)
    private var was_pushed = false
    private var factor = UserDefaults.standard.integer(forKey: "animation_speed") + 1
    
    override func didMove(to view: SKView) {
        self.addChild(playNode)
        
        sfx.append(SKAction.playSoundFileNamed("C4", waitForCompletion: false))
        sfx.append(SKAction.playSoundFileNamed("D4", waitForCompletion: false))
        sfx.append(SKAction.playSoundFileNamed("E4", waitForCompletion: false))
        sfx.append(SKAction.playSoundFileNamed("F4", waitForCompletion: false))
        sfx.append(SKAction.playSoundFileNamed("G4", waitForCompletion: false))
        sfx.append(SKAction.playSoundFileNamed("A5", waitForCompletion: false))
        sfx.append(SKAction.playSoundFileNamed("B5", waitForCompletion: false))
        sfx.append(SKAction.playSoundFileNamed("C5", waitForCompletion: false))
        sfx.append(SKAction.playSoundFileNamed("D5", waitForCompletion: false))
        sfx.append(SKAction.playSoundFileNamed("E5", waitForCompletion: false))
        sfx.append(SKAction.playSoundFileNamed("F5", waitForCompletion: false))
        sfx.append(SKAction.playSoundFileNamed("G5", waitForCompletion: false))
        sfx.append(SKAction.playSoundFileNamed("A6", waitForCompletion: false))
        sfx.append(SKAction.playSoundFileNamed("B6", waitForCompletion: false))
        sfx.append(SKAction.playSoundFileNamed("C6", waitForCompletion: false))
        
        back.position = CGPoint(x: self.frame.minX + 60, y: self.frame.maxY - 60)
        back.size = CGSize(width: 150.0, height: 150.0)
        playNode.addChild(back)
        
        text1.fontName = "AvenirNextCondensed-UltraLight"
        text1.fontSize = CGFloat(100.0)
        text1.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 250)
        playNode.addChild(text1)
        
        text2.fontName = "AvenirNextCondensed-UltraLight"
        text2.fontSize = CGFloat(70.0)
        text2.position = CGPoint(x: self.frame.midX, y: text1.frame.midY - 120)
        playNode.addChild(text2)
        
        text3.fontName = "AvenirNextCondensed-UltraLight"
        text3.fontSize = CGFloat(70.0)
        text3.position = CGPoint(x: self.frame.midX, y: text2.frame.midY - 90)
        playNode.addChild(text3)
        
        text4.fontName = "AvenirNextCondensed-UltraLight"
        text4.fontSize = CGFloat(70.0)
        text4.position = CGPoint(x: self.frame.midX, y: text3.frame.midY - 120)
        playNode.addChild(text4)
        
        text5.fontName = "AvenirNextCondensed-UltraLight"
        text5.fontSize = CGFloat(70.0)
        text5.position = CGPoint(x: self.frame.midX, y: text4.frame.midY - 90)
        playNode.addChild(text5)
        
        text6.fontName = "AvenirNextCondensed-UltraLight"
        text6.fontSize = CGFloat(70.0)
        text6.position = CGPoint(x: self.frame.midX, y: text5.frame.midY - 90)
        playNode.addChild(text6)
        
        text7.fontName = "AvenirNextCondensed-UltraLight"
        text7.fontSize = CGFloat(70.0)
        text7.position = CGPoint(x: self.frame.midX, y: text6.frame.midY - 90)
        playNode.addChild(text7)
        
        text8.fontName = "AvenirNextCondensed-UltraLight"
        text8.fontSize = CGFloat(70.0)
        text8.position = CGPoint(x: self.frame.midX, y: text7.frame.midY - 90)
        playNode.addChild(text8)

        text9.fontName = "AvenirNextCondensed-UltraLight"
        text9.fontSize = CGFloat(70.0)
        text9.position = CGPoint(x: self.frame.midX, y: text8.frame.midY - 120)
        playNode.addChild(text9)
        
        text10.fontName = "AvenirNextCondensed-UltraLight"
        text10.fontSize = CGFloat(70.0)
        text10.position = CGPoint(x: self.frame.midX, y: text9.frame.midY - 90)
        playNode.addChild(text10)
        
        cont.fontName = "AvenirNextCondensed-UltraLight"
        cont.position = CGPoint(x: self.frame.midX, y: text10.frame.midY - 150)
        cont.fontSize = CGFloat(90.0)
        let fadeAction = SKAction.sequence([SKAction.fadeOut(withDuration: 1.0), SKAction.fadeIn(withDuration: 1.0)])
        cont.run(SKAction.repeatForever(fadeAction))
        playNode.addChild(cont)
        
        init_squares()
        
        firstRound()
    }
    
    func init_squares() {
        
        for squares in 0...8 {
            arraySquares.append(SKSpriteNode())
            arrayFrames.append(SKSpriteNode())
            arrayLabels.append(SKLabelNode())
            arrayMoved.append(false)
            arraySquares[squares].size = CGSize(width: 180, height: 180)
            arraySquares[squares].texture = SKTexture(imageNamed: "paint")
            arrayFrames[squares].size = CGSize(width: 180, height: 180)
            arrayLabels[squares].zPosition = 3
            arraySquares[squares].zPosition = 2
            arrayFrames[squares].zPosition = 1
        }
        
        arraySquares[0].position = CGPoint(x: self.frame.midX - 190, y: self.frame.midY + 210)
        arraySquares[1].position = CGPoint(x: self.frame.midX, y: self.frame.midY + 210)
        arraySquares[2].position = CGPoint(x: self.frame.midX + 190, y:self.frame.midY + 210)
        arraySquares[3].position = CGPoint(x: self.frame.midX - 190, y: self.frame.midY + 20)
        arraySquares[4].position = CGPoint(x: self.frame.midX, y:self.frame.midY + 20)
        arraySquares[5].position = CGPoint(x: self.frame.midX + 190, y: self.frame.midY + 20)
        arraySquares[6].position = CGPoint(x: self.frame.midX - 190, y: self.frame.midY - 170)
        arraySquares[7].position = CGPoint(x: self.frame.midX, y: self.frame.midY - 170)
        arraySquares[8].position = CGPoint(x: self.frame.midX + 190, y: self.frame.midY - 170)
        
        for i in 0...8 {
            arrayFrames[i].position = arraySquares[i].position
            arrayFrames[i].texture = SKTexture(imageNamed: "square_frame")
            
            arraySquares[i].alpha = 0.0
            
            arrayLabels[i].position = CGPoint(x: arraySquares[i].frame.midX - 5, y: arraySquares[i].frame.midY - 20)
            arrayLabels[i].alpha = 1.0
            arrayLabels[i].fontSize = CGFloat(70.0)
            arrayLabels[i].fontName = "AvenirNextCondensed-UltraLight"
            
            simNode.addChild(arrayFrames[i])
            simNode.addChild(arraySquares[i])
            simNode.addChild(arrayLabels[i])
            
        }
        
        simNode.isHidden = true
        simNode.isPaused = true
        playNode.addChild(simNode)
    }
    
    func firstRound() {
        let increment = 0.9 / Double(2)
        var dif = 0.0
        
        cur = 3
        arrayPositions.append(cur)
        arraySquares[cur].alpha = 0.1 + CGFloat(dif)
        arrayFrames[cur].alpha = 0.0
        arrayLabels[cur].text = String(2)
        arrayLabels[cur].alpha = 1.0
        dif = dif + increment
        
        cur = 4
        arrayPositions.append(cur)
        arraySquares[cur].alpha = 0.1 + CGFloat(dif)
        arrayFrames[cur].alpha = 0.0
        arrayLabels[cur].text = String(1)
        arrayLabels[cur].alpha = 1.0
        dif = dif + increment
        
        cur = 2
        arrayPositions.append(cur)
        arraySquares[cur].alpha = 1.0
        compare = arrayPositions.remove(at: 0)
    }

    func gen() -> Int {
        var pos = Int(arc4random_uniform(9))
        var unique = false
        if(arrayPositions.isEmpty) {
            return pos
        }
        else {
            var count = 0
            while(!unique) {
                if(count == 2 || count == arrayPositions.count) {
                    unique = true
                }
                else if(arrayPositions[count] == pos) {
                    pos = Int(arc4random_uniform(9))
                    count = 0
                }
                else {
                    count = count + 1
                }
            }
        }
        return pos
    }
    
    func setupRound() {
        self.view?.isUserInteractionEnabled = false
        stop_animate_compare()
        if(UserDefaults.standard.bool(forKey: "sound_off") == false) {
            self.run(sfx[note])
        }
        note = note + 1
        if(note == 15) {
            note = 0
        }
        
        for i in 0...8 {
            arrayMoved[i] = false
        }
        score2 += 1
        let temp = cur
        if(score2 <= 2) {
            if(score2 == 2) {
                text1.text = "After that it's your job to"
                text2.text = "remember. Enjoy the game!"
            }
            arraySquares[compare].run(SKAction.fadeOut(withDuration: 1.0 / Double(factor)))
            arrayLabels[compare].run(SKAction.fadeOut(withDuration: 1.0 / Double(factor)))
            arrayFrames[compare].run(SKAction.fadeAlpha(to: 1.0, duration: 1.0 / Double(factor)))
            cur = gen()
        }
        else {
            cur = Int(arc4random_uniform(9))
        }
        
        compare = arrayPositions.remove(at: 0)
        arrayPositions.append(cur)
        arraySquares[temp].run(SKAction.fadeOut(withDuration: 1.0 / Double(factor)))
        {
            self.arraySquares[self.cur].run(SKAction.fadeIn(withDuration: 1.0 / Double(self.factor))) {
                self.animate_compare()
                self.run(SKAction.wait(forDuration: 1.0 / Double(self.factor))) {
                    self.view?.isUserInteractionEnabled = true
                }
            }
        }
    }

    func disappear() {
        let action = SKAction.fadeOut(withDuration: 0.6)
        text1.run(action)
        text2.run(action)
        text3.run(action)
        text4.run(action)
        text5.run(action)
        text6.run(action)
        text7.run(action)
        text8.run(action)
        text9.run(action)
        text10.run(action)
        cont.removeAllActions()
        cont.run(action) {
            self.text1.text = "The first n squares will"
            self.text1.fontSize = CGFloat(70.0)
            self.text2.text = "be provided to you"
            self.text2.position = CGPoint(x: self.frame.midX, y: self.text1.frame.midY - 90)
            self.text1.run(SKAction.fadeIn(withDuration: 0.6))
            self.text2.run(SKAction.fadeIn(withDuration: 0.6))
            
            self.simNode.alpha = 0.0
            self.simNode.isPaused = false
            self.simNode.isHidden = false
            self.simNode.run(SKAction.fadeIn(withDuration: 0.6))
            
            self.animate_compare()
        }
    }
    
    func animate_compare() {
        if(score2 < 2) {
            if(!was_pushed) {
                self.orig_alpha_frame = arrayFrames[compare].alpha
                self.orig_alpha = self.arraySquares[self.compare].alpha
                self.orig_alpha_label = arrayLabels[compare].alpha
            }
            
            arrayFrames[compare].alpha = 0.0
            self.arraySquares[self.compare].run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 1.0), SKAction.fadeAlpha(to: self.orig_alpha, duration: 1.0)])))
            self.arrayLabels[self.compare].run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 1.0), SKAction.fadeAlpha(to: self.orig_alpha_label, duration: 1.0)])))
        }
        else {
            if(!was_pushed)
            {
                orig_alpha_frame = arrayFrames[compare].alpha
                self.orig_alpha = self.arraySquares[self.compare].alpha
                self.orig_alpha_label = arrayLabels[compare].alpha
            }
            
            if(compare != cur) {
                self.arrayFrames[self.compare].run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 1.0), SKAction.fadeAlpha(to: self.orig_alpha_frame, duration: 1.0)])))
            }
            else {
                arrayFrames[compare].alpha = 0.0
                self.arraySquares[self.compare].run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 1.0), SKAction.fadeAlpha(to: self.orig_alpha, duration: 1.0)])))
            }
        }
    }
    
    func stop_animate_compare() {
        arraySquares[compare].removeAllActions()
        arraySquares[compare].alpha = orig_alpha
        
        arrayLabels[compare].removeAllActions()
        arrayLabels[compare].alpha = orig_alpha_label
        
        arrayFrames[compare].alpha = orig_alpha_frame
        arrayFrames[compare].removeAllActions()
        was_pushed = false
    }
    
    func stop_animate_hover() {
        arraySquares[compare].removeAllActions()
        arraySquares[compare].alpha = orig_alpha / CGFloat(2.0)
        
        arrayLabels[compare].removeAllActions()
        arrayLabels[compare].alpha = orig_alpha_label / CGFloat(2.0)
        
        arrayFrames[compare].removeAllActions()
        
        if(compare == cur) {
            arrayFrames[compare].alpha = 0.0
        }
        else {
            arrayFrames[compare].alpha = orig_alpha_frame / CGFloat(2.0)
        }
        
        was_pushed = true
    }
    
    func push_down(pos: Int) {
        if(pos == compare) {
            stop_animate_hover()
        }
        else {
            arraySquares[pos].alpha = arraySquares[pos].alpha / CGFloat(2)
            arrayLabels[pos].alpha = arrayLabels[pos].alpha / CGFloat(2)
        
            if(pos == cur) {
                arrayFrames[pos].alpha = 0
            }
            else {
                arrayFrames[pos].alpha = arrayFrames[pos].alpha / CGFloat(2)
            }
        }
        arrayMoved[pos] = true
    }
    
    func push_up(pos: Int) {
        if(pos == compare) {
            animate_compare()
        }
        else {
            arraySquares[pos].alpha = arraySquares[pos].alpha * CGFloat(2)
            arrayLabels[pos].alpha = arrayLabels[pos].alpha * CGFloat(2)
        
            if(pos == cur) {
                arrayFrames[pos].alpha = 1.0
            }
            else {
                arrayFrames[pos].alpha = arrayFrames[pos].alpha * CGFloat(2)
            }
        }
        arrayMoved[pos] = false
    }
    
    func check_began(pos: Int, location: CGPoint) -> Bool {
        return self.atPoint(location) == self.arraySquares[pos] || self.atPoint(location) == self.arrayLabels[pos] || self.atPoint(location) == self.arrayFrames[pos]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(check_began(pos: 0, location: location)) {
                push_down(pos: 0)
            }
            else if(check_began(pos: 1, location: location)) {
                push_down(pos: 1)
            }
            else if(check_began(pos: 2, location: location)) {
                push_down(pos: 2)
            }
            else if(check_began(pos: 3, location: location)) {
                push_down(pos: 3)
            }
            else if(check_began(pos: 4, location: location)) {
                push_down(pos: 4)
            }
            else if(check_began(pos: 5, location: location)) {
                push_down(pos: 5)
            }
            else if(check_began(pos: 6, location: location)) {
                push_down(pos: 6)
            }
            else if(check_began(pos: 7, location: location)) {
                push_down(pos: 7)
            }
            else if(check_began(pos: 8, location: location)) {
                push_down(pos: 8)
            }
            else if(self.atPoint(location) == self.back) {
                back.alpha = 0.5
                back_touch = true
            }
        }
    }
    
    func check_moved_out(pos: Int, loc: CGPoint) -> Bool {
        return arrayMoved[pos] && (self.atPoint(loc) != self.arraySquares[pos] && self.atPoint(loc) != self.arrayLabels[pos] && self.atPoint(loc) != self.arrayFrames[pos])
    }
    
    func check_moved_in(pos: Int, loc: CGPoint) -> Bool {
        return !arrayMoved[pos] && (self.atPoint(loc) == self.arraySquares[pos] || self.atPoint(loc) == self.arrayFrames[pos] || self.atPoint(loc) == self.arrayLabels[pos])
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(check_moved_in(pos: 0, loc: location)) {
                push_down(pos: 0)
            }
            else if(check_moved_in(pos: 1, loc: location)) {
                push_down(pos: 1)
            }
            else if(check_moved_in(pos: 2, loc: location)) {
                push_down(pos: 2)
            }
            else if(check_moved_in(pos: 3, loc: location)) {
                push_down(pos: 3)
            }
            else if(check_moved_in(pos: 4, loc: location)) {
                push_down(pos: 4)
            }
            else if(check_moved_in(pos: 5, loc: location)) {
                push_down(pos: 5)
            }
            else if(check_moved_in(pos: 6, loc: location)) {
                push_down(pos: 6)
            }
            else if(check_moved_in(pos: 7, loc: location)) {
                push_down(pos: 7)
            }
            else if(check_moved_in(pos: 8, loc: location)) {
                push_down(pos: 8)
            }
            else if(back_touch && self.atPoint(location) != self.back) {
                back.alpha = 1.0
                back_touch = false
            }
                
            if(check_moved_out(pos: 0, loc: location)) {
                push_up(pos: 0)
            }
            else if(check_moved_out(pos: 1, loc: location)) {
                push_up(pos: 1)
            }
            else if(check_moved_out(pos: 2, loc: location)) {
                push_up(pos: 2)
            }
            else if(check_moved_out(pos: 3, loc: location)) {
                push_up(pos: 3)
            }
            else if(check_moved_out(pos: 4, loc: location)) {
                push_up(pos: 4)
            }
            else if(check_moved_out(pos: 5, loc: location)) {
                push_up(pos: 5)
            }
            else if(check_moved_out(pos: 6, loc: location)) {
                push_up(pos: 6)
            }
            else if(check_moved_out(pos: 7, loc: location)) {
                push_up(pos: 7)
            }
            else if(check_moved_out(pos: 8, loc: location)) {
                push_up(pos: 8)
            }
            else if(self.atPoint(location) == self.back && !back_touch) {
                back.alpha = 0.5
                back_touch = true
            }
        }
    }
    
    func check_ended(pos: Int, loc: CGPoint) -> Bool {
        return self.atPoint(loc) == self.arraySquares[pos] || self.atPoint(loc) == self.arrayFrames[pos] || self.atPoint(loc) == self.arrayLabels[pos]
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(self.atPoint(location) == self.arraySquares[compare] || self.atPoint(location) == self.arrayLabels[compare] || self.atPoint(location) == self.arrayFrames[compare]) {
                
                push_up(pos: compare)
                setupRound()
            }
            else if(check_ended(pos: 0, loc: location)) {
                push_up(pos: 0)
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            else if(check_ended(pos: 1, loc: location)) {
                push_up(pos: 1)
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            else if(check_ended(pos: 2, loc: location)) {
                push_up(pos: 2)
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            else if(check_ended(pos: 3, loc: location)) {
                push_up(pos: 3)
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            else if(check_ended(pos: 4, loc: location)) {
                push_up(pos: 4)
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            else if(check_ended(pos: 5, loc: location)) {
                push_up(pos: 5)
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            else if(check_ended(pos: 6, loc: location)) {
                push_up(pos: 6)
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            else if(check_ended(pos: 7, loc: location)) {
                push_up(pos: 7)
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            else if(check_ended(pos: 8, loc: location)) {
                push_up(pos: 8)
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            else if(back_touch && self.atPoint(location) == self.back) {
                back.alpha = 1.0
                back_touch = false
                
                if let view = self.view {
                    // Load the SKScene from 'GameScene.sks'
                    if let scene = SKScene(fileNamed: "GameScene") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFill
                        
                        // Present the scene
                        view.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.6))
                    }
                }
            }
            else if(!should_disappear) {
                disappear()
                should_disappear = true
            }
        }
    }
    
}
