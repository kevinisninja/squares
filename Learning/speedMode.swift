//
//  speedMode.swift
//  Learning
//
//  Created by Kevin Zhang on 7/14/17.
//  Copyright © 2017 Kevin Zhang. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import GoogleMobileAds
import AudioToolbox

class speedMode: SKScene {
    
    private var sfx : [SKAction] = [SKAction]()
    private var note = 0
    private var up = true
    
    var interstitial: GADInterstitial!
    
    private var parentNode = SKNode()
    private var audioNode = SKNode()
    private var n_back2 = SKLabelNode(text: "n_back: 1")
    private var score = SKLabelNode(text: "Score: 0")
    
    private var score2 = 0
    private var n_back = UserDefaults.standard.integer(forKey: "difficulty")
    private var cur = 0
    private var compare = 0
    private var ans = 0
    private var stopPlay = false
    private var missed_one = false
    private var tired = false
    
    private var arrayLives : [SKSpriteNode] = [SKSpriteNode]()
    private var lives = 3
    private var sequence = SKAction.sequence([SKAction.animate(with: [SKTexture(imageNamed: "hb1"), SKTexture(imageNamed: "hb2")], timePerFrame: 0.05), SKAction.fadeOut(withDuration: 0.05)])
    
    private var arraySquares : [SKSpriteNode] = [SKSpriteNode]()
    private var arrayFrames : [SKSpriteNode] = [SKSpriteNode]()
    private var arrayLabels : [SKLabelNode] = [SKLabelNode]()
    private var arrayMoved = [Bool]()
    private var arrayPositions = [Int]()
    private var fadeAction : SKAction = SKAction()
    
    private var orig_alpha = CGFloat(0.0)
    private var orig_alpha_label = CGFloat(0.0)
    private var orig_alpha_frame = CGFloat(0.0)
    private var was_pushed = false
    
    private var pauseNode = SKNode()
    private var pauseIcon = SKSpriteNode(imageNamed: "pause")
    private var pauseBack = SKSpriteNode()
    
    private var pause_menu = SKLabelNode(text: "Back to Menu")
    private var menu_touch = false
    
    private var pause_close = SKSpriteNode(imageNamed: "close")
    private var close_touch = false
    
    private var pause_restart = SKLabelNode(text: "Restart")
    private var restart_touch = false
    
    private var gameOverNode = SKNode()
    private var gameOverBack = SKSpriteNode()
    private var go_text = SKLabelNode(text: "Game Over!")
    private var go_hiscore = SKLabelNode(text: "New Highscore!")
    private var go_menuButton = SKLabelNode(text: "Back to Menu")
    private var go_playAgain = SKLabelNode(text: "Play Again")

    var timer = Timer()
    var counter = 0
    var time_left = SKLabelNode(text: "30")
    var first_touch = true
    
    private var repet = SKLabelNode(text: "Where was the white square")
    private var repet2 = SKLabelNode(text: " turns ago?")
    
    override func didMove(to view: SKView) {
        //add children to the parent node because for some reason my positioning was screwing up
        self.addChild(self.parentNode)
        
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
        
        //adding buttons, replace these later with images
        score.text = "Score: " + String(score2)
        score.fontName = "AvenirNextCondensed-UltraLight"
        score.fontSize = CGFloat(90.0)
        score.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 360)
        score.zPosition = 1
        parentNode.addChild(self.score)
        
        repet2.text = String(n_back) + " turns ago?"
        repet.fontSize = CGFloat(70.0)
        repet.fontName = "AvenirNextCondensed-UltraLight"
        repet2.fontSize = CGFloat(70.0)
        repet2.fontName = "AvenirNextCondensed-UltraLight"
        repet.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 350)
        repet2.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 430)
        parentNode.addChild(repet)
        parentNode.addChild(repet2)
        
        time_left.fontName = "AvenirNextCondensed-UltraLight"
        time_left.fontSize = CGFloat(90.0)
        time_left.zPosition = 1
        time_left.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 100)
        parentNode.addChild(time_left)
        
        fadeAction = SKAction.sequence([SKAction.fadeOut(withDuration: 1.0), SKAction.fadeIn(withDuration: 1.0)])
        
        interstitial = createAndLoadInterstitial()
        let request = GADRequest()
        interstitial.load(request)
        
        init_squares()
        
        for i in 0...2 {
            arrayLives.append(SKSpriteNode(imageNamed: "heart"))
            arrayLives[i].zPosition = 1
            arrayLives[i].size = CGSize(width: 90.0, height: 90.0)
        }
        
        arrayLives[2].position = CGPoint(x: self.frame.maxX - 70, y: self.frame.maxY - 70)
        arrayLives[1].position = CGPoint(x: arrayLives[2].frame.midX - 70, y: self.frame.maxY - 70)
        arrayLives[0].position = CGPoint(x: arrayLives[1].frame.midX - 70, y: self.frame.maxY - 70)
        
        for i in 0...2 {
            parentNode.addChild(arrayLives[i])
        }
        
        setup_gameOver()
        setup_pause()
        
        firstRound()
    }
    
    func timerAction() {
        counter += 1
        time_left.text = String(30 - counter)
        
        if(counter == 30) {
            present_gameOver()
        }
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial2 = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/1033173712")
        interstitial2.delegate = self as? GADInterstitialDelegate
        interstitial2.load(GADRequest())
        return interstitial2
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
    func setup_pause() {
        pauseIcon.size = CGSize(width: 100.0, height: 100.0)
        pauseIcon.position = CGPoint(x: self.frame.minX + 70,y: self.frame.maxY - 70)
        pauseIcon.zPosition = 1
        parentNode.addChild(pauseIcon)
        
        pauseBack.zPosition = 4
        pauseBack.color = UIColor(white: 0.0, alpha: 0.8)
        pauseBack.size = self.size
        pauseBack.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        pauseNode.addChild(pauseBack)
        
        pause_menu.zPosition = 5
        pause_menu.text = "Back to Menu"
        pause_menu.fontName = "AvenirNextCondensed-UltraLight"
        pause_menu.fontSize = CGFloat(90.0)
        pause_menu.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 180)
        pauseNode.addChild(pause_menu)
        
        pause_restart.zPosition = 5
        pause_restart.text = "Restart"
        pause_restart.fontName = "AvenirNextCondensed-UltraLight"
        pause_restart.fontSize = CGFloat(90.0)
        pause_restart.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 190)
        pauseNode.addChild(pause_restart)
        
        pause_close.zPosition = 5
        pause_close.position = CGPoint(x: self.frame.minX + 70, y: self.frame.maxY - 70)
        pause_close.size = CGSize(width: 150.0, height: 150.0)
        pauseNode.addChild(pause_close)
        
        pauseNode.isHidden = true
        pauseNode.isPaused = true
        parentNode.addChild(pauseNode)
    }
    
    func setup_gameOver() {
        
        //this is the transparent background
        gameOverBack.zPosition = 4
        gameOverBack.color = UIColor(white: 0.0, alpha: 0.8)
        gameOverBack.size = self.size
        gameOverBack.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        gameOverNode.addChild(self.gameOverBack)
        
        //buttons on the GUI
        go_menuButton.zPosition = 5
        go_menuButton.text = "Back to Menu"
        go_menuButton.fontName = "AvenirNextCondensed-UltraLight"
        go_menuButton.fontSize = CGFloat(90.0)
        go_menuButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 1)
        gameOverNode.addChild(self.go_menuButton)
        
        go_playAgain.zPosition = 5
        go_playAgain.text = "Play Again"
        go_playAgain.fontName = "AvenirNextCondensed-UltraLight"
        go_playAgain.fontSize = CGFloat(90.0)
        go_playAgain.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 190)
        gameOverNode.addChild(self.go_playAgain)
        
        go_text.zPosition = 5
        go_text.text = "Game Over!"
        go_text.fontName = "AvenirNextCondensed-UltraLight"
        go_text.fontSize = CGFloat(90.0)
        go_text.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 280)
        gameOverNode.addChild(self.go_text)
        
        gameOverNode.isHidden = true
        gameOverNode.isPaused = true
        parentNode.addChild(gameOverNode)
        
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
            
            parentNode.addChild(arrayFrames[i])
            parentNode.addChild(arraySquares[i])
            parentNode.addChild(arrayLabels[i])
            
        }
    }
    
    func firstRound() {
        let increment = 0.9 / Double(n_back)
        var dif = 0.0
        for i in 1...n_back {
            cur = gen()
            arrayPositions.append(cur)
            arraySquares[cur].alpha = 0.1 + CGFloat(dif)
            arrayFrames[cur].alpha = 0.0
            arrayLabels[cur].text = String(n_back + 1 - i)
            arrayLabels[cur].alpha = 1.0
            dif = dif + increment
        }
        
        
        cur = gen()
        arrayPositions.append(cur)
        arraySquares[cur].alpha = 1.0
        compare = arrayPositions.remove(at: 0)
        animate_compare()
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
                if(count == n_back || count == arrayPositions.count) {
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
        missed_one = false
        if(UserDefaults.standard.bool(forKey: "sound_off") == false) {
            self.run(sfx[note])
            
            if(up) {
                note = note + 1
                if(note == 15) {
                    up = false
                    note = 13
                    if(lives < 3) {
                        arrayLives[lives].texture = SKTexture(imageNamed: "heart")
                        arrayLives[lives].run(SKAction.fadeIn(withDuration: 0.05))
                        lives = lives + 1
                    }
                }
            }
            else {
                note = note - 1
                if(note == -1 && !up) {
                    up = true
                    note = 1
                    if(lives < 3) {
                        arrayLives[lives].texture = SKTexture(imageNamed: "heart")
                        arrayLives[lives].run(SKAction.fadeIn(withDuration: 0.05))
                        lives = lives + 1
                    }
                }
            }
        }
        
        for i in 0...8 {
            arrayMoved[i] = false
        }
        
        if(score2 < 5) {
            repet.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.05), SKAction.fadeIn(withDuration: 0.05)]))
            repet2.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.05 ), SKAction.fadeIn(withDuration: 0.05)]))
            
        }
        else if(score2 == 5) {
            repet.run(SKAction.fadeOut(withDuration: 0.05))
            repet2.run(SKAction.fadeOut(withDuration: 0.05))
        }
        
        score2 += 1
        score.text = "Score: " + String(score2)
        if(score2 <= n_back || tired) {
            stop_animate_compare()
        }
        let temp = cur
        if(score2 <= n_back) {
            arraySquares[compare].run(SKAction.fadeOut(withDuration: 0.05))
            arrayLabels[compare].run(SKAction.fadeOut(withDuration: 0.05))
            arrayFrames[compare].run(SKAction.fadeAlpha(to: 1.0, duration: 0.05))
            cur = gen()
        }
        else {
            cur = Int(arc4random_uniform(9))
        }
        
        compare = arrayPositions.remove(at: 0)
        arrayPositions.append(cur)
        
        arraySquares[temp].run(SKAction.fadeOut(withDuration: 0.05))
        {
            self.arraySquares[self.cur].run(SKAction.fadeIn(withDuration: 0.05))
            if(self.score2 < self.n_back) {
                self.animate_compare()
            }
        }
    }
    
    func check_began(pos: Int, location: CGPoint) -> Bool {
        return !stopPlay && self.atPoint(location) == self.arraySquares[pos] || self.atPoint(location) == self.arrayLabels[pos] || self.atPoint(location) == self.arrayFrames[pos]
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
            else if(stopPlay && self.atPoint(location) == self.go_playAgain) {
                go_playAgain.alpha = 0.5
            }
            else if(stopPlay && self.atPoint(location) == self.go_menuButton) {
                go_menuButton.alpha = 0.5
            }
            else if(!stopPlay && self.atPoint(location) == self.pauseIcon) {
                pauseIcon.alpha = 0.5
            }
            else if(stopPlay && self.atPoint(location) == self.pause_menu) {
                menu_touch = true
                pause_menu.alpha = 0.5
            }
            else if(stopPlay && self.atPoint(location) == self.pause_restart) {
                pause_restart.alpha = 0.5
                restart_touch = true
            }
            else if(stopPlay && self.atPoint(location) == self.pause_close) {
                pause_close.alpha = 0.5
                close_touch = true
            }
        }
    }
    
    func check_moved_out(pos: Int, loc: CGPoint) -> Bool {
        return !stopPlay && arrayMoved[pos] && (self.atPoint(loc) != self.arraySquares[pos] && self.atPoint(loc) != self.arrayLabels[pos] && self.atPoint(loc) != self.arrayFrames[pos])
    }
    
    func check_moved_in(pos: Int, loc: CGPoint) -> Bool {
        return !stopPlay && !arrayMoved[pos] && (self.atPoint(loc) == self.arraySquares[pos] || self.atPoint(loc) == self.arrayFrames[pos] || self.atPoint(loc) == self.arrayLabels[pos])
        
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
            else if(!stopPlay && self.atPoint(location) != self.pauseIcon) {
                pauseIcon.alpha = 1.0
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
            else if(!stopPlay && self.atPoint(location) == self.pauseIcon) {
                pauseIcon.alpha = 0.5
            }
            
            if(stopPlay && self.atPoint(location) != self.go_playAgain) {
                go_playAgain.alpha = 1.0
            }
            else if(stopPlay && self.atPoint(location) == self.go_playAgain) {
                go_playAgain.alpha = 0.5
            }
            
            if(stopPlay && self.atPoint(location) != self.go_menuButton) {
                go_menuButton.alpha = 1.0
            }
            else if(stopPlay && self.atPoint(location) == self.go_menuButton) {
                go_menuButton.alpha = 0.5
            }
            
            if(stopPlay && menu_touch && self.atPoint(location) != self.pause_menu) {
                pause_menu.alpha = 1.0
                menu_touch = false
            }
            else if(stopPlay && !menu_touch && self.atPoint(location) == self.pause_menu) {
                pause_menu.alpha = 0.5
                menu_touch = true
            }
            
            if(stopPlay && restart_touch && self.atPoint(location) != self.pause_restart) {
                pause_restart.alpha = 1.0
                restart_touch = false
            }
            else if(stopPlay && !restart_touch && self.atPoint(location) == self.pause_restart) {
                pause_restart.alpha = 0.5
                restart_touch = true
            }
            
            if(stopPlay && close_touch && self.atPoint(location) != self.pause_close) {
                pause_close.alpha = 1.0
                close_touch = false
            }
            else if(stopPlay && !close_touch && self.atPoint(location) == self.pause_close) {
                pause_close.alpha = 0.5
                close_touch = true
            }
        }
    }
    
    func check_ended(pos: Int, loc: CGPoint) -> Bool {
        return !stopPlay && self.atPoint(loc) == self.arraySquares[pos] || self.atPoint(loc) == self.arrayFrames[pos] || self.atPoint(loc) == self.arrayLabels[pos]
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(first_touch) {
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
                first_touch = false
            }
            if(check_ended(pos: compare, loc: location)) {
                
                push_up(pos: compare)
                setupRound()
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
            else if(!stopPlay && self.atPoint(location) == self.pauseIcon) {
                pauseIcon.alpha = 1.0
                stopPlay = true
                pauseNode.isPaused = false
                pauseNode.isHidden = false
                
                pauseNode.alpha = 0.0
                pauseNode.run(SKAction.fadeAlpha(to: 0.9, duration: 0.6))
                timer.invalidate()
                
            }
            else if(stopPlay && menu_touch && self.atPoint(location) == self.pause_menu) {
                pause_menu.alpha = 1.0
                menu_touch = false
                
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
            else if(stopPlay && restart_touch && self.atPoint(location) == self.pause_restart) {
                pause_restart.alpha = 1.0
                restart_touch = false
                
                let scene = speedMode(size: self.size)
                let skview = self.view!
                skview.ignoresSiblingOrder = true
                scene.scaleMode = .aspectFill
                skview.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.6))
            }
            else if(stopPlay && close_touch && self.atPoint(location) == self.pause_close) {
                pause_close.alpha = 1.0
                close_touch = false
                stopPlay = false
                pauseNode.run(SKAction.fadeAlpha(to: 0.0, duration: 0.6)) {
                    self.pauseNode.isPaused = true
                    self.pauseNode.isHidden = true
                }
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            }
            else if(stopPlay && self.atPoint(location) == self.go_playAgain) {
                go_playAgain.alpha = 1.0
                if(UserDefaults.standard.integer(forKey: "no_ad_streak") >= 5) {
                    UserDefaults.standard.set(0, forKey: "no_ad_streak")
                    if interstitial.isReady {
                        parentNode.isPaused = true
                        interstitial.present(fromRootViewController: (self.view?.window?.rootViewController)!)
                    }
                }
                else {
                    UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "no_ad_streak") + 1, forKey: "no_ad_streak")
                }
                let scene = speedMode(size: self.size)
                let skview = self.view!
                skview.ignoresSiblingOrder = true
                scene.scaleMode = .aspectFill
                skview.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.6))
            }
            else if(stopPlay && self.atPoint(location) == self.go_menuButton) {
                go_menuButton.alpha = 1.0
                if(UserDefaults.standard.integer(forKey: "no_ad_streak") >= 5) {
                    UserDefaults.standard.set(0, forKey: "no_ad_streak")
                    if interstitial.isReady {
                        interstitial.present(fromRootViewController: (self.view?.window?.rootViewController)!)
                    }
                }
                else {
                    UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "no_ad_streak") + 1, forKey: "no_ad_streak")
                }
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
        }
    }
    
    func animate_compare() {
        if(!was_pushed) {
            if(score2 >= n_back) {
                orig_alpha = 0.0
                orig_alpha_frame = 1.0
                orig_alpha_label = 0.0
                tired = true
            }
            else {
                self.orig_alpha_frame = arrayFrames[compare].alpha
                self.orig_alpha = self.arraySquares[self.compare].alpha
                self.orig_alpha_label = arrayLabels[compare].alpha
            }
        }
        
        if(score2 >= n_back) {
            arrayFrames[compare].alpha = 1.0
            self.arrayFrames[compare].run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 0.75), SKAction.fadeAlpha(to: self.orig_alpha_frame, duration: 0.75)])))
        }
        else {
            arrayFrames[compare].alpha = 0.0
            self.arraySquares[self.compare].run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 0.75), SKAction.fadeAlpha(to: self.orig_alpha, duration: 0.75)])))
            self.arrayLabels[self.compare].run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 0.75), SKAction.fadeAlpha(to: self.orig_alpha_label, duration: 0.75)])))
        }
    }
    
    func stop_animate_compare() {
        tired = false
        arraySquares[compare].removeAllActions()
        arraySquares[compare].alpha = orig_alpha
        
        arrayLabels[compare].removeAllActions()
        arrayLabels[compare].alpha = orig_alpha_label
        
        arrayFrames[compare].removeAllActions()
        arrayFrames[compare].alpha = orig_alpha_frame
        was_pushed = false
    }
    
    func stop_animate_hover() {
        
        arraySquares[compare].removeAllActions()
        arraySquares[compare].alpha = orig_alpha / CGFloat(2.0)
        
        arrayLabels[compare].removeAllActions()
        arrayLabels[compare].alpha = orig_alpha_label / CGFloat(2.0)
        
        arrayFrames[compare].removeAllActions()
        arrayFrames[compare].alpha = orig_alpha_frame / CGFloat(2.0)
        was_pushed = true
    }
    
    func push_down(pos: Int) {
        if(score2 < n_back && pos == compare) {
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
        if(score2 < n_back && pos == compare) {
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
    
    
    func fail() {
        if(missed_one) {
            missed_one = false
            animate_compare()
        }
        
        missed_one = true
        lives = lives - 1
        play_vib()
        note = 0
        up = true
        if(lives == 0) {
            arrayLives[lives].run(sequence)
            {
                self.present_gameOver()
            }
        }
        else if(lives > 0 && lives < 3){
            arrayLives[lives].run(sequence)
        }
        
    }
    
    func present_gameOver() {
        timer.invalidate()
        score.zPosition = 5
        if(n_back == 2 && score2 > UserDefaults.standard.integer(forKey: "easy_speed_hi")) {
            UserDefaults.standard.set(score2, forKey: "easy_speed_hi")
            
            setup_labels_gameover()
            gameOverNode.addChild(go_hiscore)
        }
        else if(n_back == 3 && score2 > UserDefaults.standard.integer(forKey: "normal_speed_hi")) {
            UserDefaults.standard.set(score2, forKey: "normal_speed_hi")
            setup_labels_gameover()
            gameOverNode.addChild(go_hiscore)
        }
        else if(n_back == 4 && score2 > UserDefaults.standard.integer(forKey: "hard_speed_hi")) {
            UserDefaults.standard.set(score2, forKey: "hard_speed_hi")
            setup_labels_gameover()
            gameOverNode.addChild(go_hiscore)
        }
        else {
            if(n_back == 2) {
                go_hiscore.text = "Current Highscore: " + String(UserDefaults.standard.integer(forKey: "easy_speed_hi"))
            }
            else if(n_back == 3) {
                go_hiscore.text = "Current Highscore: " + String(UserDefaults.standard.integer(forKey: "normal_speed_hi"))
            }
            else if(n_back == 4) {
                go_hiscore.text = "Current Highscore: " + String(UserDefaults.standard.integer(forKey: "hard_speed_hi"))
            }
            gameOverNode.addChild(go_hiscore)
            go_hiscore.zPosition = 5
            go_hiscore.fontName = "AvenirNextCondensed-UltraLight"
            go_hiscore.fontSize = CGFloat(90.0)
            go_hiscore.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 450)
            go_text.run(SKAction.repeatForever(fadeAction))
        }
        
        self.gameOverNode.isHidden = false
        gameOverNode.isPaused = false
        self.stopPlay = true
        
        gameOverNode.alpha = 0.0
        gameOverNode.run(SKAction.fadeAlpha(to: 0.9, duration: 0.6))
    }
    
    func setup_labels_gameover() {
        go_hiscore.zPosition = 5
        go_hiscore.text = "New Highscore!"
        go_hiscore.fontName = "AvenirNextCondensed-UltraLight"
        go_hiscore.fontSize = CGFloat(90.0)
        go_hiscore.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 450)
        go_hiscore.run(SKAction.repeatForever(fadeAction))
    }
    
    func play_vib() {
        if(UserDefaults.standard.bool(forKey: "vib_off") == false) {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
    
}
