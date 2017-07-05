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
        
        hiscore.position = CGPoint(x: self.frame.maxX - 60, y: self.frame.maxY - 60)
        playNode.addChild(self.hiscore)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if self.atPoint(location) == self.hiscore {
                hiscore.texture = SKTexture(imageNamed: "hiscore_touched")
                hiscore_touch = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(hiscore_touch && self.atPoint(location) != self.hiscore) {
                hiscore.texture = SKTexture(imageNamed: "hiscore")
                hiscore_touch = false
            }
            else if(self.atPoint(location) == self.hiscore && !hiscore_touch) {
                hiscore.texture = SKTexture(imageNamed: "hiscore_touched")
                hiscore_touch = true
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(hiscore_touch && self.atPoint(location) == self.hiscore) {
                hiscore.texture = SKTexture(imageNamed: "hiscore")
                hiscore_touch = false

                let scene = hiscores(size: self.size)
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
        blink()
    }
    
    func blink() {
        if(fade)
        {
            text.alpha = text.alpha - 0.1
            
            if(text.alpha == 0.1) {
                fade = false
            }
        }
        else {
            text.alpha = text.alpha + 0.1
            
            if(text.alpha == 1) {
                fade = true
            }
        }
    }
    
 }
