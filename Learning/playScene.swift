//
//  playScene.swift
//  Learning
//
//  Created by Kevin Zhang on 6/5/17.
//  Copyright © 2017 Kevin Zhang. All rights reserved.
//

import SpriteKit
import UIKit
class playScene: SKScene {
    
    private var parentNode = SKNode()
    private var yesButton = SKSpriteNode(imageNamed: "yes")
    private var noButton = SKSpriteNode(imageNamed: "no")
    private var n_back2 = SKLabelNode(text: "n_back: 1")
    private var score = SKLabelNode(text: "Score: 0")

    private var score2 = 0
    private var n_back = UserDefaults.standard.integer(forKey: "difficulty")
    private var cur = 0
    private var compare = 0
    private var ans = 0
    private var stopPlay = false
    
    private var arraySquares : [SKSpriteNode] = [SKSpriteNode]()
    private var arrayPositions = [Int]()
    
    private var gameOverNode = SKNode()
    private var gameOverBack = SKSpriteNode()
    private var go_text = SKLabelNode(text: "Game Over!")
    private var go_menuButton = SKLabelNode(text: "Back to Menu")
    private var go_playAgain = SKLabelNode(text: "Play Again")
    
    private var pauseNode = SKNode()
    
    override func didMove(to view: SKView) {
        
        //add children to the parent node because for some reason my positioning was screwing up
        self.addChild(self.parentNode)
        
        //adding buttons, replace these later with images
        score.text = "Score: " + String(score2)
        score.fontName = "AvenirNextCondensed-UltraLight"
        score.fontSize = CGFloat(90.0)
        score.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 150)
        score.zPosition = 2
        parentNode.addChild(self.score)
        
        n_back2.text = "n_back: " + String(n_back)
        n_back2.fontName = "AvenirNextCondensed-UltraLight"
        n_back2.fontSize = CGFloat(70.0)
        n_back2.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 250)
        n_back2.zPosition = 2
        parentNode.addChild(self.n_back2)
        
        yesButton.position = CGPoint(x: self.frame.midX + 50, y: self.frame.midX - 80)
        yesButton.zPosition = 2
        parentNode.addChild(self.yesButton)
        
        noButton.position = CGPoint(x: self.frame.midX - 50, y: self.frame.midX - 80)
        noButton.zPosition = 2
        parentNode.addChild(self.noButton)
        
        init_squares()
        
        setup_pause()
        
        setup_gameOver()
        
        firstRound()
    }
    
    func setup_gameOver() {
        
        //this is the transparent background
        gameOverBack.zPosition = 3
        gameOverBack.color = UIColor(white: 0.0, alpha: 0.67)
        gameOverBack.size = self.size
        gameOverBack.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        gameOverNode.addChild(self.gameOverBack)
        
        //buttons on the GUI
        go_menuButton.zPosition = 4
        go_menuButton.text = "Back to Menu"
        go_menuButton.fontName = "AvenirNextCondensed-UltraLight"
        go_menuButton.fontSize = CGFloat(70.0)
        go_menuButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        gameOverNode.addChild(self.go_menuButton)
        
        go_playAgain.zPosition = 4
        go_playAgain.text = "Play Again"
        go_playAgain.fontName = "AvenirNextCondensed-UltraLight"
        go_playAgain.fontSize = CGFloat(70.0)
        go_playAgain.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 200)
        gameOverNode.addChild(self.go_playAgain)
        
        go_text.zPosition = 4
        go_text.text = "Game Over!"
        go_text.fontName = "AvenirNextCondensed-UltraLight"
        go_text.fontSize = CGFloat(90.0)
        go_text.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 300)
        gameOverNode.addChild(self.go_text)
    }
    
    func setup_pause() {
        
    }
    
    func init_squares() {
        
        for squares in 0...8 {
            arraySquares.append(SKSpriteNode())
            arraySquares[squares].size = CGSize(width: 90, height: 90)
            self.arraySquares[squares].zPosition = 2
            parentNode.addChild(arraySquares[squares])
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
    }
    
    func firstRound() {
        cur = Int(arc4random_uniform(4))
        compare = Int(arc4random_uniform(4))
        arrayPositions.append(cur)
        
        while(compare == cur) {
            compare = Int(arc4random_uniform(4))
        }
        
        arraySquares[cur].texture = SKTexture(imageNamed: "paint")
        arraySquares[compare].texture = SKTexture(imageNamed: "previous")

        ans = 0
    }
    
    func setupRound() {
        
        score2 += 1
        score.text = "Score " + String(score2)
        
        arraySquares[compare].texture = SKTexture()
        arraySquares[cur].texture = SKTexture()
        
        compare = arrayPositions.remove(at: 0)
        cur = Int(arc4random_uniform(4))
        arrayPositions.append(cur)
        
        arraySquares[cur].texture = SKTexture(imageNamed: "paint")
        
        if(cur == compare) {
            ans = 1
        }
        else {
            ans = 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(self.atPoint(location) == self.yesButton && !stopPlay) {
                if(ans == 1) {
                    setupRound()
                }
                else {
                    stopPlay = true
                    parentNode.addChild(self.gameOverNode)
                }
            }
            else if(self.atPoint(location) == self.noButton && !stopPlay) {
                if(ans == 0) {
                    setupRound()
                }
                else {
                    stopPlay = true
                    parentNode.addChild(self.gameOverNode)
                }
            }
            else if(self.atPoint(location) == self.go_playAgain && stopPlay) {
                
                let scene = playScene(size: self.size)
                let skview = self.view!
                skview.ignoresSiblingOrder = true
                scene.scaleMode = .aspectFill
                skview.presentScene(scene)
            }
            else if(self.atPoint(location) == self.go_menuButton && stopPlay) {
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
}
