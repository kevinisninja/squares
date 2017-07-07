//
//  GameScene.swift
//  Learning
//
//  Created by Kevin Zhang on 6/5/17.
//  Copyright © 2017 Kevin Zhang. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    private var playNode = SKNode()
    private var hiscore = SKSpriteNode(imageNamed: "hiscore")
    private var hiscore_touch = false
    private var _instructions = SKSpriteNode(imageNamed: "instructions")
    private var instructions_touch = false
    
    private var title = SKLabelNode(text: "S q u a r e s")
    private var text = SKLabelNode(text: "Tap to start")
    private var fade = true
    
    
    override func didMove(to view: SKView) {
        self.addChild(self.playNode)
        
        title.fontName = "AvenirNextCondensed-UltraLight"
        title.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 270)
        title.fontSize = CGFloat(140.0)
        playNode.addChild(self.title)
        
        text.fontName = "AvenirNextCondensed-UltraLight"
        text.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 50)
        text.fontSize = CGFloat(70.0)
        let fadeAction = SKAction.sequence([SKAction.fadeOut(withDuration: 1.0), SKAction.fadeIn(withDuration: 1.0)])
        text.run(SKAction.repeatForever(fadeAction))
        
        playNode.addChild(text)
        
        _instructions.position = CGPoint(x: self.frame.maxX - 60,y: self.frame.maxY - 60)
        playNode.addChild(self._instructions)
        
        hiscore.position = CGPoint(x: _instructions.frame.midX - 100, y: self.frame.maxY - 60)
        playNode.addChild(self.hiscore)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if self.atPoint(location) == self.hiscore {
                hiscore.alpha = 0.5
                hiscore_touch = true
            }
            else if self.atPoint(location) == self._instructions {
                _instructions.alpha = 0.5
                instructions_touch = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(hiscore_touch && self.atPoint(location) != self.hiscore) {
                hiscore.alpha = 1.0
                hiscore_touch = false
            }
            else if(!hiscore_touch && self.atPoint(location) == self.hiscore) {
                hiscore.alpha = 0.5
                hiscore_touch = true
            }
            else if(instructions_touch && self.atPoint(location) != self._instructions) {
                _instructions.alpha = 1.0
                instructions_touch = false
            }
            else if(!instructions_touch && self.atPoint(location) == self._instructions) {
                _instructions.alpha = 0.5
                instructions_touch = true
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(hiscore_touch && self.atPoint(location) == self.hiscore) {
                hiscore.alpha = 1.0
                hiscore_touch = false

                let scene = hiscores(size: self.size)
                let skview = self.view!
                skview.ignoresSiblingOrder = true
                scene.scaleMode = .aspectFill
                skview.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.6))
            }
            else if(instructions_touch && self.atPoint(location) == self._instructions) {
                _instructions.alpha = 1.0
                instructions_touch = false
                
                let scene = instructions(size: self.size)
                let skview = self.view!
                skview.ignoresSiblingOrder = true
                scene.scaleMode = .aspectFill
                skview.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.6))
            }
            else {
                let scene = DifficultySelect(size: self.size)
                let skview = self.view!
                skview.ignoresSiblingOrder = true
                scene.scaleMode = .aspectFill
                skview.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.6))
            }
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
 }
