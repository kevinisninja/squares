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

    private var audioNode = SKNode()
    private var sfx : [SKAction] = [SKAction]()
    private var note = 0
    
    private var done = false
    private var timer = Timer()
    private var simNode = SKNode()
    private var arraySquares : [SKSpriteNode] = [SKSpriteNode]()
    private var arrayFrames : [SKSpriteNode] = [SKSpriteNode]()
    private var arrayLabels : [SKLabelNode] = [SKLabelNode]()
    private var arrayPositions : [Int] = [Int]()
    private var arrayMoved = [Bool]()
    private var cur = 0
    private var compare = 0
    private var score2 = 0
    private var round = 0
    
    private var up = true
    private var orig_alpha = CGFloat(0.0)
    private var orig_alpha_label = CGFloat(0.0)
    private var orig_alpha_frame = CGFloat(0.0)
    private var was_pushed = false
    
    private var text1 = SKLabelNode(text: "Follow the white square!")
    private var text2 = SKLabelNode(text: "Tap to continue")
    private var text2_touch = false
    private var text1_2 = SKLabelNode(text: "sample")
    
    private var text3 = SKLabelNode(text: "One more time!")
    private var text3_touch = false
    
    private var test1 = SKSpriteNode(imageNamed: "tut_back")
    private var test2 = SKSpriteNode(imageNamed: "tut_back")
    
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
        
        if(UserDefaults.standard.bool(forKey: "completed_tutorial") == true) {
            back.position = CGPoint(x: self.frame.minX + 60, y: self.frame.maxY - 60)
            back.size = CGSize(width: 150.0, height: 150.0)
            playNode.addChild(back)
        }

        setup()
        
        init_squares()
        
        firstRound()
    }
    
    func setup() {
        
        text1.fontName = "AvenirNextCondensed-UltraLight"
        text1.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 400)
        text1.fontSize = CGFloat(70.0)
        playNode.addChild(text1)
        
        text1_2.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 430)
        text1_2.fontSize = CGFloat(70.0)
        text1_2.fontName = "AvenirNextCondensed-UltraLight"
        text1_2.text = "For normal, it'll be: "
        text1_2.alpha = 0.0
        playNode.addChild(text1_2)
        
        text2.fontName = "AvenirNextCondensed-UltraLight"
        text2.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 400)
        text2.fontSize = CGFloat(70.0)
        let fadeAction = SKAction.sequence([SKAction.fadeOut(withDuration: 1.0), SKAction.fadeIn(withDuration: 1.0)])
        text2.run(SKAction.repeatForever(fadeAction))
        playNode.addChild(text2)
        
        text3.fontName = "AvenirNextCondensed-UltraLight"
        text3.fontSize = CGFloat(70.0)
        text3.position = CGPoint(x: self.frame.midX, y: text2.frame.midY - 100)
        text3.alpha = 0.0
        playNode.addChild(text3)
        
        test1.zRotation = CGFloat(Double.pi)
        test1.position = CGPoint(x: self.frame.midX - 125, y: self.frame.midY + 20)
        test1.alpha = 0.0
        playNode.addChild(test1)
        
        test2.zRotation = CGFloat(Double.pi + Double.pi / 4)
        test2.position = CGPoint(x: self.frame.midX + 70, y: self.frame.midY + 90)
        test2.alpha = 0.0
        playNode.addChild(test2)
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
        playNode.addChild(simNode)
    }
    
    func firstRound() {
        cur = 3
        arrayPositions.append(cur)
        arraySquares[cur].alpha = 0.0
        arraySquares[cur].run(SKAction.fadeIn(withDuration: 0.75))
        arrayFrames[cur].run(SKAction.fadeOut(withDuration: 0.75))
        round = 1
        compare = 3
    }

    func secondRound() {
        cur = 4
        arrayPositions.append(cur)
        arraySquares[cur].alpha = 0.0
        
        arrayLabels[3].alpha = 0.0
        arrayLabels[3].text = "1"
        arrayLabels[3].run(SKAction.fadeIn(withDuration: 0.75))
        test1.run(SKAction.fadeIn(withDuration: 0.75))
        arraySquares[3].run(SKAction.fadeAlpha(to: 0.55, duration: 0.75))
        
        
        arraySquares[cur].alpha = 0.0
        arraySquares[cur].run(SKAction.fadeIn(withDuration: 0.75))
        arrayFrames[cur].run(SKAction.fadeOut(withDuration: 0.75))
        
        text1.run(SKAction.fadeOut(withDuration: 0.375))
        {
            self.text1.text = "Remember the order!"
            self.text1.run(SKAction.fadeIn(withDuration: 0.375))
        }
        round = 2
        compare = 4
    }
    
    func thirdRound() {
        cur = 2
        arrayPositions.append(cur)
        arraySquares[cur].alpha = 0.0
        
        arraySquares[3].run(SKAction.fadeAlpha(to: 0.1, duration: 0.75))
        arrayLabels[3].run(SKAction.fadeOut(withDuration: 0.375)) {
            self.arrayLabels[3].text = "2"
            self.arrayLabels[3].run(SKAction.fadeIn(withDuration: 0.375))
        }
        
        test2.run(SKAction.fadeIn(withDuration: 0.75))
        arraySquares[4].run(SKAction.fadeAlpha(to: 0.55, duration: 0.75))
        arrayLabels[4].text = "1"
        arrayLabels[4].run(SKAction.fadeIn(withDuration: 0.75))
        
        arraySquares[cur].run(SKAction.fadeIn(withDuration: 0.75))
        
        self.text2.removeAllActions()
        self.text2.run(SKAction.fadeOut(withDuration: 0.75)) {
            self.text2.text = "Try Again!"
        }
        text1.run(SKAction.fadeOut(withDuration: 0.75)) {
            self.text1.text = "Where was it 2 turns ago?"
            self.text1.run(SKAction.fadeIn(withDuration: 0.75))
        }
        
        compare = arrayPositions.remove(at: 0)
        round = 3
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
    
    func timerAction() {
        animate_compare()
        timer.invalidate()
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
        stop_animate_compare()
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: false)
        
        if(score2 < 4)
        {
            text1.run(SKAction.fadeOut(withDuration: 0.75)) {
                self.text1.run(SKAction.fadeIn(withDuration: 0.75))
            }
        }
        else if(score2 == 4) {
            text1.run(SKAction.fadeOut(withDuration: 0.75)) {
                self.text1.text = "You've got the idea!"
                self.text1.run(SKAction.fadeIn(withDuration: 0.75))
            }
        }
        else if(score2 == 5) {
            text1_2.run(SKAction.fadeOut(withDuration: 0.75)) {
                self.text1_2.text = "Getting 15 in a row "
                self.text1_2.run(SKAction.fadeIn(withDuration: 0.75))
            }
            text1.run(SKAction.fadeOut(withDuration: 0.75)) {
                self.text1.text = "will get you another life!"
                self.text1.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 350)
                self.text1.run(SKAction.fadeIn(withDuration: 0.75))
                self.text2.text = "Play Now"
                self.text2.run(SKAction.fadeIn(withDuration: 0.75))
                self.done = true
                UserDefaults.standard.set(true, forKey: "completed_tutorial")
            }
        }

        
        if(UserDefaults.standard.bool(forKey: "sound_off") == false) {
            self.run(sfx[note])
            
            if(up) {
                note = note + 1
                if(note == 15 && up) {
                    up = false
                    note = 13
                }
            }
            else {
                note = note - 1
                if(note == -1 && !up) {
                    up = true
                    note = 1
                }
            }
        }
        
        for i in 0...8 {
            arrayMoved[i] = false
        }
        
        score2 += 1
        
        let temp = cur
        cur = gen()
        
        compare = arrayPositions.remove(at: 0)
        arrayPositions.append(cur)
        if(score2 == 1) {
            arraySquares[4].run(SKAction.fadeAlpha(to: 0.1, duration: 0.75))
            arrayLabels[4].run(SKAction.fadeOut(withDuration: 0.375)) {
                self.arrayLabels[4].text = "2"
                self.arrayLabels[4].run(SKAction.fadeIn(withDuration: 0.375))
            }
        }
        arraySquares[temp].run(SKAction.fadeOut(withDuration: 0.75))
        {
            self.arraySquares[self.cur].run(SKAction.fadeIn(withDuration: 0.75))
        }
    }
    
    func animate_compare() {
        if( (score2 == 0 && round == 3 && compare == 3) && !was_pushed) {
            arraySquares[compare].run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 0.75), SKAction.fadeAlpha(to: 0.1, duration: 0.75)])))
            arrayLabels[compare].run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 0.75), SKAction.fadeAlpha(to: 1.0, duration: 0.75)])))
            test1.run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 0.75), SKAction.fadeAlpha(to: 1.0, duration: 0.75)])))
        }
        else if( (score2 == 1 && round == 3 && compare == 4) && !was_pushed) {
            arraySquares[compare].run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 0.75), SKAction.fadeAlpha(to: 0.10, duration: 0.75)])))
            arrayLabels[compare].run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 0.75), SKAction.fadeAlpha(to: 1.0, duration: 0.75)])))
            test2.run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 0.75), SKAction.fadeAlpha(to: 1.0, duration: 0.75)])))
        }
        else if( !was_pushed ) {
            arrayFrames[compare].run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 0.75), SKAction.fadeAlpha(to: 1.0, duration: 0.75)])))
        }
    }
    
    func stop_animate_compare() {
        if( (score2 == 0 && round == 3 && compare == 3) ) {
            arraySquares[compare].removeAllActions()
            arrayLabels[compare].removeAllActions()
            test1.removeAllActions()
            
            arraySquares[compare].alpha = 0.1
            arrayLabels[compare].alpha = 1.0
            test1.alpha = 1.0
            
            arraySquares[compare].run(SKAction.fadeOut(withDuration: 0.75))
            arrayLabels[compare].run(SKAction.fadeOut(withDuration: 0.75))
            test1.run(SKAction.fadeOut(withDuration: 0.75))
            arrayFrames[compare].run(SKAction.fadeIn(withDuration: 0.75))
        }
        else if( (score2 == 1 && round == 3 && compare == 4) ) {
            arraySquares[compare].removeAllActions()
            arrayLabels[compare].removeAllActions()
            test2.removeAllActions()
            
            arraySquares[compare].alpha = 0.10
            arrayLabels[compare].alpha = 1.0
            test2.alpha = 1.0
            
            arraySquares[compare].run(SKAction.fadeOut(withDuration: 0.75))
            arrayLabels[compare].run(SKAction.fadeOut(withDuration: 0.75))
            test2.run(SKAction.fadeOut(withDuration: 0.75))
            arrayFrames[compare].run(SKAction.fadeIn(withDuration: 0.75))
        }
        else {
            arrayFrames[compare].removeAllActions()
            arrayFrames[compare].alpha = 1.0
        }
        was_pushed = false
    }
    
    func stop_animate_hover() {
        
        if( (score2 == 0 && round == 3 && compare == 3) ) {
            arraySquares[compare].removeAllActions()
            arrayLabels[compare].removeAllActions()
            test1.removeAllActions()
            
            arraySquares[compare].alpha = 0.05
            arrayLabels[compare].alpha = 0.5
            test1.alpha = 0.5
            
            was_pushed = true
            return
        }
        else if( (score2 == 1 && round == 3 && compare == 4) ) {
            arraySquares[compare].removeAllActions()
            arrayLabels[compare].removeAllActions()
            test2.removeAllActions()
            
            arraySquares[compare].alpha = 0.05
            arrayLabels[compare].alpha = 0.5
            test2.alpha = 0.5
            
            was_pushed = true
            return
        }
        else {
            arrayFrames[compare].removeAllActions()
        }
        was_pushed = true
    }
    
    func push_down(pos: Int) {
        
        if( (round == 1 && pos == 3 ) || (round == 2 && pos == 4) || (score2 == 0 && round == 3 && pos == 2) ) {
            arraySquares[pos].alpha = 0.5
        }
        else if( (round == 2 && pos == 3) || (score2 == 0 && round == 3 && pos == 4) ) {
            arraySquares[pos].alpha = 0.275
            arrayLabels[pos].alpha = 0.5
            if(pos == 3) {
                test1.alpha = 0.5
            }
            else if(pos == 4) {
                test2.alpha = 0.5
            }
        }
        else if( (score2 == 0 && round == 3 && pos == 3) || (score2 == 1 && round == 3 && pos == 4) ) {
            stop_animate_hover()
        }
        else if(pos == compare) {
            stop_animate_hover()
            arrayFrames[compare].alpha = 0.5
        }
        else {
            arrayFrames[pos].alpha = 0.5
        }
        
        arrayMoved[pos] = true
    }
    
    func push_up(pos: Int) {
        if( (round == 1 && pos == 3 ) || (round == 2 && pos == 4) || (score2 == 0 && round == 3 && pos == 2) ) {
            arraySquares[pos].alpha = 1.0
        }
        else if( (round == 2 && pos == 3) || (score2 == 0 && round == 3 && pos == 4) ) {
            arraySquares[pos].alpha = 0.55
            arrayLabels[pos].alpha = 1.0
            if(pos == 3) {
                test1.alpha = 1.0
            }
            else if(pos == 4) {
                test2.alpha = 1.0
            }
        }
        else if( (score2 == 0 && round == 3 && pos == 3) || (score2 == 1 && round == 3 && pos == 4) ) {
            was_pushed = false
            animate_compare()
        }
        else if(pos == compare) {
            arrayFrames[compare].alpha = 1.0
            animate_compare()
        }
        else {
            arrayFrames[pos].alpha = 1.0
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
            else if(self.atPoint(location) == self.text2 && done) {
                text2.alpha = 0.5
                text2_touch = true
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
            else if(text2_touch && self.atPoint(location) != self.text2 && done) {
                text2.alpha = 1.0
                text2_touch = false
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
            else if(!text2_touch && self.atPoint(location) == self.text2 && done) {
                text2.alpha = 0.5
                text2_touch = true
            }
        }
    }
    
    func check_ended(pos: Int, loc: CGPoint) -> Bool {
        return self.atPoint(loc) == self.arraySquares[pos] || self.atPoint(loc) == self.arrayFrames[pos] || self.atPoint(loc) == self.arrayLabels[pos]
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(check_ended(pos: compare, loc: location)) {
                push_up(pos: compare)
                if(round == 3) {
                    setupRound()
                }
            }
            else if(check_ended(pos: 0, loc: location)) {
                push_up(pos: 0)
                fail()
            }
            else if(check_ended(pos: 1, loc: location)) {
                push_up(pos: 1)
                fail()
            }
            else if(check_ended(pos: 2, loc: location)) {
                push_up(pos: 2)
                fail()
            }
            else if(check_ended(pos: 3, loc: location)) {
                push_up(pos: 3)
                fail()
            }
            else if(check_ended(pos: 4, loc: location)) {
                push_up(pos: 4)
                fail()
            }
            else if(check_ended(pos: 5, loc: location)) {
                push_up(pos: 5)
                fail()
            }
            else if(check_ended(pos: 6, loc: location)) {
                push_up(pos: 6)
                fail()
            }
            else if(check_ended(pos: 7, loc: location)) {
                push_up(pos: 7)
                fail()
            }
            else if(check_ended(pos: 8, loc: location)) {
                push_up(pos: 8)
                fail()
            }
            else if(back_touch && self.atPoint(location) == self.back) {
                back.alpha = 1.0
                back_touch = false
                
                if let view = self.view {
                    // Load the SKScene from 'GameScene.sks'
                    if let scene = SKScene(fileNamed: "GameScene") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFit
                        
                        // Present the scene
                        view.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.6))
                    }
                }
            }
            else if(text2_touch && self.atPoint(location) == self.text2 && done) {
                text2.alpha = 1.0
                text2_touch = false
                
                let scene = DifficultySelect(size: self.size)
                let skview = self.view!
                skview.ignoresSiblingOrder = true
                scene.scaleMode = .aspectFit
                skview.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.6))
            }
            
            if(round == 1) {
                secondRound()
            }
            else if(round == 2) {
                thirdRound()
            }
            
        }
    }
    
    func fail() {
        if(round == 3) {
            play_vib()
        }
    }
    func play_vib() {
        if(UserDefaults.standard.bool(forKey: "vib_off") == false) {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
    
}
