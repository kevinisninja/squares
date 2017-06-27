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
    
    private var background = SKSpriteNode(imageNamed: "background_trans_final")
    
    override func didMove(to view: SKView) {
        self.background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.background.zPosition = 1
        self.addChild(self.background)
        
        score.text = "Score " + String(score2)
        score.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 75)
        self.score.zPosition = 2
        self.addChild(self.score)
        
        n_back2.text = "n_back: " + String(n_back)
        n_back2.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 100)
        self.n_back2.zPosition = 2
        self.addChild(self.n_back2)
        
        
        let square0 : SKSpriteNode!
        square0 = SKSpriteNode()
        arraySquares.append(square0)
        
        let square1 : SKSpriteNode!
        square1 = SKSpriteNode()
        arraySquares.append(square1)
        
        let square2 : SKSpriteNode!
        square2 = SKSpriteNode()
        arraySquares.append(square2)
        
        let square3 : SKSpriteNode!
        square3 = SKSpriteNode()
        arraySquares.append(square3)
        
        for squares in 0...3 {
            arraySquares[squares].size = CGSize(width: 140, height: 140)
        }
        
        arraySquares[0].position = CGPoint(x: self.frame.midX - 75, y: self.frame.midY - 75)
        arraySquares[1].position = CGPoint(x: self.frame.midX + 75, y: self.frame.midY - 75)
        arraySquares[2].position = CGPoint(x: self.frame.midX - 75, y: self.frame.midY + 75)
        arraySquares[3].position = CGPoint(x: self.frame.midX + 75, y: self.frame.midY + 75)
        
        for squares in 0...3 {
            self.arraySquares[squares].zPosition = 2
            self.addChild(self.arraySquares[squares])
        }
        let bottom = CGPoint(x:arraySquares[0].position.x, y:arraySquares[0].position.y - 140)
        yesButton.position = bottom
        self.yesButton.zPosition = 2
        self.addChild(self.yesButton)
        
        let bottomNo = CGPoint(x:arraySquares[1].position.x, y:arraySquares[0].position.y - 140)
        noButton.position = bottomNo
        self.noButton.zPosition = 2
        self.addChild(self.noButton)
        
        firstRound()
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
                    let scene = gameOver(size: self.size)
                    let skview = self.view!
                    skview.ignoresSiblingOrder = true
                    skview.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.25))
                }
            }
            
            else if self.atPoint(location) == self.noButton {
                if(ans == 0) {
                    setupRound()
                }
                else {
                    let scene = gameOver(size: self.size)
                    let skview = self.view!
                    skview.ignoresSiblingOrder = true
                    skview.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.25))
                }
            }
            
        }
    }
}
