
//
//  playScene.swift
//  Learning
//
//  Created by Kevin Zhang on 6/5/17.
//  Copyright © 2017 Kevin Zhang. All rights reserved.
//

import SpriteKit
import UIKit
import GoogleMobileAds
import AudioToolbox

class playScene: SKScene {
    
    private var sfx : [SKAction] = [SKAction]()
    private var note = 0
    
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
    
    private var arrayLives : [SKSpriteNode] = [SKSpriteNode]()
    private var lives = 3
    private var sequence = SKAction.sequence([SKAction.animate(with: [SKTexture(imageNamed: "hb1"), SKTexture(imageNamed: "hb2")], timePerFrame: 0.1), SKAction.fadeOut(withDuration: 0.2)])
    
    private var arraySquares : [SKSpriteNode] = [SKSpriteNode]()
    private var arrayFrames : [SKSpriteNode] = [SKSpriteNode]()
    private var arrayLabels : [SKLabelNode] = [SKLabelNode]()
    private var arrayMoved = [Bool]()
    private var arrayPositions = [Int]()
    private var factor = UserDefaults.standard.integer(forKey: "animation_speed") + 1
    private var fadeAction : SKAction = SKAction()
    
    private var gameOverNode = SKNode()
    private var gameOverBack = SKSpriteNode()
    private var go_text = SKLabelNode(text: "Game Over!")
    private var go_hiscore = SKLabelNode(text: "New Highscore!")
    private var go_menuButton = SKLabelNode(text: "Back to Menu")
    private var go_playAgain = SKLabelNode(text: "Play Again")
    
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
        score.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 150)
        score.zPosition = 1
        parentNode.addChild(self.score)
        
        n_back2.text = "n_back: " + String(n_back)
        n_back2.fontName = "AvenirNextCondensed-UltraLight"
        n_back2.fontSize = CGFloat(70.0)
        n_back2.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 250)
        n_back2.zPosition = 1
        parentNode.addChild(self.n_back2)
        
        fadeAction = SKAction.sequence([SKAction.fadeOut(withDuration: 1.0), SKAction.fadeIn(withDuration: 1.0)])
        
        for i in 0...2 {
            arrayLives.append(SKSpriteNode(imageNamed: "heart"))
            arrayLives[i].zPosition = 1
            arrayLives[i].size = CGSize(width: 150.0, height: 150.0)
        }
        
        arrayLives[0].position = CGPoint(x: self.frame.midX - 150, y: self.frame.maxY - 200)
        arrayLives[1].position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 200)
        arrayLives[2].position = CGPoint(x: self.frame.midX + 150, y: self.frame.maxY - 200)
        
        for i in 0...2 {
            parentNode.addChild(arrayLives[i])
        }
        
        interstitial = createAndLoadInterstitial()
        let request = GADRequest()
        interstitial.load(request)

        init_squares()
        
        setup_gameOver()
        
        firstRound()
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
    func setup_gameOver() {
        
        //this is the transparent background
        gameOverBack.zPosition = 4
        gameOverBack.color = UIColor(white: 0.0, alpha: 0.9)
        gameOverBack.size = self.size
        gameOverBack.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        gameOverNode.addChild(self.gameOverBack)
        
        //buttons on the GUI
        go_menuButton.zPosition = 5
        go_menuButton.text = "Back to Menu"
        go_menuButton.fontName = "AvenirNextCondensed-UltraLight"
        go_menuButton.fontSize = CGFloat(70.0)
        go_menuButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 1)
        gameOverNode.addChild(self.go_menuButton)
        
        go_playAgain.zPosition = 5
        go_playAgain.text = "Play Again"
        go_playAgain.fontName = "AvenirNextCondensed-UltraLight"
        go_playAgain.fontSize = CGFloat(70.0)
        go_playAgain.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 200)
        gameOverNode.addChild(self.go_playAgain)
        
        go_text.zPosition = 5
        go_text.text = "Game Over!"
        go_text.fontName = "AvenirNextCondensed-UltraLight"
        go_text.fontSize = CGFloat(90.0)
        go_text.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 300)
        gameOverNode.addChild(self.go_text)
        
        gameOverNode.isHidden = true
        parentNode.addChild(gameOverNode)
        
    }
    
    func init_squares() {
        
        for squares in 0...8 {
            arraySquares.append(SKSpriteNode())
            arrayFrames.append(SKSpriteNode())
            arrayLabels.append(SKLabelNode())
            arrayMoved.append(false)
            arraySquares[squares].size = CGSize(width: 90, height: 90)
            arraySquares[squares].texture = SKTexture(imageNamed: "paint")
            arrayFrames[squares].size = CGSize(width: 89, height: 89)
            arrayLabels[squares].zPosition = 3
            arraySquares[squares].zPosition = 2
            arrayFrames[squares].zPosition = 1
        }
        
        arraySquares[0].position = CGPoint(x: self.frame.midX - 100, y: self.frame.midY + 120)
        arraySquares[1].position = CGPoint(x: self.frame.midX, y: self.frame.midY + 120)
        arraySquares[2].position = CGPoint(x: self.frame.midX + 100, y:self.frame.midY + 120)
        arraySquares[3].position = CGPoint(x: self.frame.midX - 100, y: self.frame.midY + 20)
        arraySquares[4].position = CGPoint(x: self.frame.midX, y:self.frame.midY + 20)
        arraySquares[5].position = CGPoint(x: self.frame.midX + 100, y: self.frame.midY + 20)
        arraySquares[6].position = CGPoint(x: self.frame.midX - 100, y: self.frame.midY - 80)
        arraySquares[7].position = CGPoint(x: self.frame.midX, y: self.frame.midY - 80)
        arraySquares[8].position = CGPoint(x: self.frame.midX + 100, y: self.frame.midY - 80)
        
        for i in 0...8 {
            arrayFrames[i].position = arraySquares[i].position
            arrayFrames[i].texture = SKTexture(imageNamed: "square_frame")
            
            arraySquares[i].alpha = 0.0
            
            arrayLabels[i].position = CGPoint(x: arraySquares[i].frame.midX - 2, y: arraySquares[i].frame.midY - 15)
            arrayLabels[i].alpha = 1.0
            arrayLabels[i].fontSize = CGFloat(40.0)
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
        if(UserDefaults.standard.bool(forKey: "sound_off") == false) {
            self.run(sfx[note])
        }
        note = note + 1
        if(note == 15) {
            note = 0
            if(lives < 3) {
                arrayLives[lives].texture = SKTexture(imageNamed: "heart")
                arrayLives[lives].run(SKAction.fadeIn(withDuration: 0.2))
                lives = lives + 1
            }
        }
        
        for i in 0...8 {
            arrayMoved[i] = false
        }
        score2 += 1
        score.text = "Score: " + String(score2)
        let temp = cur
        if(score2 <= n_back) {
            arraySquares[compare].run(SKAction.fadeOut(withDuration: 1.0 / Double(factor)))
            arrayLabels[compare].run(SKAction.fadeOut(withDuration: 1.0 / 1.0 / Double(factor)))
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
            self.arraySquares[self.cur].run(SKAction.fadeIn(withDuration: 1.0 / Double(self.factor)))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(!stopPlay && self.atPoint(location) == self.arraySquares[0] || self.atPoint(location) == self.arrayLabels[0] || self.atPoint(location) == self.arrayFrames[0]) {
                push_down(pos: 0)
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[1] || self.atPoint(location) == self.arrayLabels[1] || self.atPoint(location) == self.arrayFrames[1]) {
                push_down(pos: 1)
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[2] || self.atPoint(location) == self.arrayLabels[2] || self.atPoint(location) == self.arrayFrames[2]) {
                push_down(pos: 2)
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[3] || self.atPoint(location) == self.arrayLabels[3] || self.atPoint(location) == self.arrayFrames[3]) {
                push_down(pos: 3)
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[4] || self.atPoint(location) == self.arrayLabels[4] || self.atPoint(location) == self.arrayFrames[4]) {
                push_down(pos: 4)
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[5] || self.atPoint(location) == self.arrayLabels[5] || self.atPoint(location) == self.arrayFrames[5]) {
                push_down(pos: 5)
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[6] || self.atPoint(location) == self.arrayLabels[6] || self.atPoint(location) == self.arrayFrames[6]) {
                push_down(pos: 6)
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[7] || self.atPoint(location) == self.arrayLabels[7] || self.atPoint(location) == self.arrayFrames[7]) {
                push_down(pos: 7)
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[8] || self.atPoint(location) == self.arrayLabels[8] || self.atPoint(location) == self.arrayFrames[8]) {
                push_down(pos: 8)
            }
            else if(stopPlay && self.atPoint(location) == self.go_playAgain) {
                go_playAgain.alpha = 0.5
            }
            else if(stopPlay && self.atPoint(location) == self.go_menuButton) {
                go_menuButton.alpha = 0.5
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            if(!stopPlay && self.atPoint(location) == self.arraySquares[0] || self.atPoint(location) == self.arrayLabels[0] || self.atPoint(location) == self.arrayFrames[0]) {
                push_down(pos: 0)
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[1] || self.atPoint(location) == self.arrayLabels[1] || self.atPoint(location) == self.arrayFrames[1]) {
                push_down(pos: 1)
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[2] || self.atPoint(location) == self.arrayLabels[2] || self.atPoint(location) == self.arrayFrames[2]) {
                push_down(pos: 2)
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[3] || self.atPoint(location) == self.arrayLabels[3] || self.atPoint(location) == self.arrayFrames[3]) {
                push_down(pos: 3)
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[4] || self.atPoint(location) == self.arrayLabels[4] || self.atPoint(location) == self.arrayFrames[4]) {
                push_down(pos: 4)
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[5] || self.atPoint(location) == self.arrayLabels[5] || self.atPoint(location) == self.arrayFrames[5]) {
                push_down(pos: 5)
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[6] || self.atPoint(location) == self.arrayLabels[6] || self.atPoint(location) == self.arrayFrames[6]) {
                push_down(pos: 6)
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[7] || self.atPoint(location) == self.arrayLabels[7] || self.atPoint(location) == self.arrayFrames[7]) {
                push_down(pos: 7)
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[8] || self.atPoint(location) == self.arrayLabels[8] || self.atPoint(location) == self.arrayFrames[8]) {
                push_down(pos: 8)
            }
            else if(save_space(pos: 0, loc: location)) {
                push_up(pos: 0)
            }
            else if(save_space(pos: 1, loc: location)) {
                push_up(pos: 1)
            }
            else if(save_space(pos: 2, loc: location)) {
                push_up(pos: 2)
            }
            else if(save_space(pos: 3, loc: location)) {
                push_up(pos: 3)
            }
            else if(save_space(pos: 4, loc: location)) {
                push_up(pos: 4)
            }
            else if(save_space(pos: 5, loc: location)) {
                push_up(pos: 5)
            }
            else if(save_space(pos: 6, loc: location)) {
                push_up(pos: 6)
            }
            else if(save_space(pos: 7, loc: location)) {
                push_up(pos: 7)
            }
            else if(save_space(pos: 8, loc: location)) {
                push_up(pos: 8)
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
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(!stopPlay && self.atPoint(location) == self.arraySquares[compare] || self.atPoint(location) == self.arrayLabels[compare] || self.atPoint(location) == self.arrayFrames[compare]) {
                
                arraySquares[compare].alpha = arraySquares[compare].alpha * 2
                arrayFrames[compare].alpha = arrayFrames[compare].alpha * 2
                arrayLabels[compare].alpha = arrayLabels[compare].alpha * 2
                setupRound()
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[0] || self.atPoint(location) == self.arrayLabels[0] || self.atPoint(location) == self.arrayFrames[0]) {
                push_up(pos: 0)
                fail()
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[1] || self.atPoint(location) == self.arrayLabels[1] || self.atPoint(location) == self.arrayFrames[1]) {
                push_up(pos: 1)
                fail()
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[2] || self.atPoint(location) == self.arrayLabels[2] || self.atPoint(location) == self.arrayFrames[2]) {
                push_up(pos: 2)
                fail()
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[3] || self.atPoint(location) == self.arrayLabels[3] || self.atPoint(location) == self.arrayFrames[3]) {
                push_up(pos: 3)
                fail()
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[4] || self.atPoint(location) == self.arrayLabels[4] || self.atPoint(location) == self.arrayFrames[4]) {
                push_up(pos: 4)
                fail()
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[5] || self.atPoint(location) == self.arrayLabels[5] || self.atPoint(location) == self.arrayFrames[5]) {
                push_up(pos: 5)
                fail()
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[6] || self.atPoint(location) == self.arrayLabels[6] || self.atPoint(location) == self.arrayFrames[6]) {
                push_up(pos: 6)
                fail()
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[7] || self.atPoint(location) == self.arrayLabels[7] || self.atPoint(location) == self.arrayFrames[7]) {
                push_up(pos: 7)
                fail()
            }
            else if(!stopPlay && self.atPoint(location) == self.arraySquares[8] || self.atPoint(location) == self.arrayLabels[8] || self.atPoint(location) == self.arrayFrames[8]) {
                push_up(pos: 8)
                fail()
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
                let scene = playScene(size: self.size)
                let skview = self.view!
                skview.ignoresSiblingOrder = true
                scene.scaleMode = .aspectFill
                skview.presentScene(scene)
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
                        view.presentScene(scene)
                    }
                }
            }
        }
    }
    
    func push_down(pos: Int) {
        
        if(!arrayMoved[pos]) {
            arrayMoved[pos] = true
            arraySquares[pos].alpha = arraySquares[pos].alpha / CGFloat(2)
            arrayLabels[pos].alpha = arrayLabels[pos].alpha / CGFloat(2)
            arrayFrames[pos].alpha = arrayFrames[pos].alpha / CGFloat(2)
        }
    }
    func push_up(pos: Int) {
        if(arrayMoved[pos]) {
            arrayMoved[pos] = false
            arraySquares[pos].alpha = arraySquares[pos].alpha * CGFloat(2)
            arrayLabels[pos].alpha = arrayLabels[pos].alpha * CGFloat(2)
            arrayFrames[pos].alpha = arrayFrames[pos].alpha * CGFloat(2)
        }
    }
    func setup_labels_gameover() {
        go_hiscore.zPosition = 5
        go_hiscore.text = "New Highscore!"
        go_hiscore.fontName = "AvenirNextCondensed-UltraLight"
        go_hiscore.fontSize = CGFloat(90.0)
        go_hiscore.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 400)
        go_hiscore.run(SKAction.repeatForever(fadeAction))
    }
    func fail() {

        lives = lives - 1
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        note = 0
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
        if(n_back == 2 && score2 > UserDefaults.standard.integer(forKey: "easy_hi")) {
            UserDefaults.standard.set(score2, forKey: "easy_hi")
            setup_labels_gameover()
            gameOverNode.addChild(go_hiscore)
        }
        else if(n_back == 3 && score2 > UserDefaults.standard.integer(forKey: "normal_hi")) {
            UserDefaults.standard.set(score2, forKey: "normal_hi")
            setup_labels_gameover()
            gameOverNode.addChild(go_hiscore)
        }
        else if(n_back == 4 && score2 > UserDefaults.standard.integer(forKey: "hard_hi")) {
            UserDefaults.standard.set(score2, forKey: "hard_hi")
            setup_labels_gameover()
            gameOverNode.addChild(go_hiscore)
        }
        else {
            if(n_back == 2) {
                go_hiscore.text = "Current Highscore: " + String(UserDefaults.standard.integer(forKey: "easy_hi"))
            }
            else if(n_back == 3) {
                go_hiscore.text = "Current Highscore: " + String(UserDefaults.standard.integer(forKey: "normal_hi"))
            }
            else if(n_back == 4) {
                go_hiscore.text = "Current Highscore: " + String(UserDefaults.standard.integer(forKey: "hard_hi"))
            }
            gameOverNode.addChild(go_hiscore)
            go_hiscore.zPosition = 5
            go_hiscore.fontName = "AvenirNextCondensed-UltraLight"
            go_hiscore.fontSize = CGFloat(90.0)
            go_hiscore.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 400)
            go_text.run(SKAction.repeatForever(fadeAction))
        }
        
        self.gameOverNode.isHidden = false
        self.stopPlay = true
    }
    func save_space(pos: Int, loc: CGPoint) -> Bool {
        return !stopPlay && self.atPoint(loc) != self.arraySquares[pos] && self.atPoint(loc) != self.arrayLabels[pos] && self.atPoint(loc) != self.arrayFrames[pos]
    }
}
