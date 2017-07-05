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
    
    
    override func didMove(to view: SKView) {
        self.addChild(self.playNode)
        
        title.fontName = "AvenirNextCondensed-UltraLight"
        title.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 270)
        title.fontSize = CGFloat(140.0)
        playNode.addChild(self.title)
        
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
                scene.scaleMode = .resizeFill
                skview.presentScene(scene, transition: SKTransition.crossFade(withDuration: 1.0))
            }
            else {
                let scene = DifficultySelect(size: self.size)
                let skview = self.view!
                skview.ignoresSiblingOrder = true
                scene.scaleMode = .resizeFill
                skview.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.5))
            }
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
 }
