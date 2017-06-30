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
    
    private var gameOverBack = SKSpriteNode()
    private var gameOver = SKSpriteNode(imageNamed: "Spaceship")
    private var go_menuButton = SKLabelNode(text: "Back to Menu")
    private var go_playAgain = SKLabelNode(text: "Play Again")
    
    private var centerX = CGFloat()
    private var centerY = CGFloat()
    
    private var arraySquares : [SKSpriteNode] = [SKSpriteNode]()
    private var yesButton = SKSpriteNode(imageNamed: "yes")
    private var noButton = SKSpriteNode(imageNamed: "no")
    
    private var score = SKLabelNode(text: "Score: 0")
    private var score2 = 0
    
    private var cur = 0
    private var compare = 0
    private var ans = 0
    
    private var n_back = 1
    private var n_back2 = SKLabelNode(text: "n_back: 1")
    private var arrayPositions = [Int]()
    
    private var parentNode = SKNode()
    private var background = SKSpriteNode(imageNamed: "background_trans_final")
    
    override func didMove(to view: SKView) {
        centerX = self.frame.midX
        centerY = self.frame.midY
        
        self.addChild(self.parentNode)
        
        background.size = self.size
        background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        background.zPosition = 1
        parentNode.addChild(self.background)
        
        score.text = "Score " + String(score2)
        score.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 75)
        self.score.zPosition = 2
        self.addChild(self.score)
        
        n_back2.text = "n_back: " + String(n_back)
        n_back2.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 100)
        self.n_back2.zPosition = 2
        self.addChild(self.n_back2)
        
        init_squares()

        let bottom = CGPoint(x:arraySquares[0].position.x, y:arraySquares[0].position.y - 140)
        yesButton.position = bottom
        self.yesButton.zPosition = 2
        self.addChild(self.yesButton)
        
        let bottomNo = CGPoint(x:arraySquares[1].position.x, y:arraySquares[0].position.y - 140)
        noButton.position = bottomNo
        self.noButton.zPosition = 2
        self.addChild(self.noButton)
        
        self.gameOverBack.zPosition = 3
        gameOverBack.color = UIColor(white: 0.0, alpha: 0.67)
        gameOverBack.size = CGSize(width: CGFloat(self.frame.width), height: CGFloat(self.frame.height))
        gameOverBack.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        self.gameOver.zPosition = 4
        self.gameOver.position = CGPoint(x: centerX, y: centerY)
        gameOverBack.addChild(gameOver)
        
        go_menuButton.text = "Back to Menu"
        go_menuButton.position = CGPoint(x: centerX - 100, y: centerY)
        
        self.go_menuButton.zPosition = 5
        gameOverBack.addChild(go_menuButton)
        
        go_playAgain.text = "Play Again"
        go_playAgain.position = CGPoint(x: centerX + 100, y: centerY)
        self.go_playAgain.zPosition = 5
        gameOverBack.addChild(go_playAgain)
        
        firstRound()
    }
    
    func init_squares() {
        
        for squares in 0...8 {
            arraySquares.append(SKSpriteNode())
            arraySquares[squares].size = CGSize(width: 90, height: 90)
            arraySquares[squares].anchorPoint = CGPoint(x: 0.5, y: 0.5)
            self.arraySquares[squares].zPosition = 2
            parentNode.addChild(arraySquares[squares])
        }
        
        arraySquares[0].position = CGPoint(x: self.frame.midX - 100, y: self.frame.midY + 100)
        arraySquares[1].position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
        arraySquares[2].position = CGPoint(x: self.frame.midX + 100, y:self.frame.midY + 100)
        arraySquares[3].position = CGPoint(x: self.frame.midX - 100, y: self.frame.midY)
        arraySquares[4].position = CGPoint(x: self.frame.midX, y:self.frame.midY)
        arraySquares[5].position = CGPoint(x: self.frame.midX + 100, y: self.frame.midY)
        arraySquares[6].position = CGPoint(x: self.frame.midX - 100, y: self.frame.midY - 100)
        arraySquares[7].position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        arraySquares[8].position = CGPoint(x: self.frame.midX + 100, y: self.frame.midY - 100)
        
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
        
        for i in 0...8 {
            arraySquares[i].texture = SKTexture(imageNamed: "paint")
        }
        ans = 0
    }
    
    func setupRound() {
        
        score2 += 1
        score.text = "Score " + String(score2)
        
        arraySquares[compare].texture = SKTexture()
        arraySquares[cur].texture = SKTexture()
        
        if( (score2 % 10 == 0 && score2 > 10) || (score2 == 5) ) {
            n_back += 1
            cur = Int(arc4random_uniform(4))
            arrayPositions.append(cur)
            
            n_back2.text = "n_back: " + String(n_back)
        }
        else
        {
            compare = arrayPositions.remove(at: 0)
            cur = Int(arc4random_uniform(4))
            arrayPositions.append(cur)
            
        }
        
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
            
            if self.atPoint(location) == self.yesButton {
                if(ans == 1) {
                    setupRound()
                }
                else {
                    self.addChild(self.gameOverBack)
                }
            }
            
            else if self.atPoint(location) == self.noButton {
                if(ans == 0) {
                    setupRound()
                }
                else {
                    self.addChild(self.gameOverBack)
                }
            }
            
        }
    }
}
