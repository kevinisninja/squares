//
//  hiscores.swift
//  Learning
//
//  Created by Kevin Zhang on 7/5/17.
//  Copyright © 2017 Kevin Zhang. All rights reserved.
//

import Foundation
import SpriteKit

class hiscores: SKScene {
    
    private var playNode = SKNode()
    private var back = SKSpriteNode(imageNamed: "back_button")
    private var back_touch = false
    
    private var crown = SKSpriteNode(imageNamed: "crown")
    private var easy_label = SKLabelNode(text: "E a s y : " + String(UserDefaults.standard.integer(forKey: "easy")))
    private var normal_label = SKLabelNode(text: "N o r m a l : " + String(UserDefaults.standard.integer(forKey: "normal")))
    private var hard_label = SKLabelNode(text: "H a r d : " + String(UserDefaults.standard.integer(forKey: "hard")))
    
    override func didMove(to view: SKView) {
        self.addChild(self.playNode)
        
        crown.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 220)
        playNode.addChild(crown)
        
        easy_label.fontName = "AvenirNextCondensed-UltraLight"
        easy_label.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
        playNode.addChild(easy_label)
        
        normal_label.fontName = "AvenirNextCondensed-UltraLight"
        normal_label.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        playNode.addChild(normal_label)
        
        hard_label.fontName = "AvenirNextCondensed-UltraLight"
        hard_label.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        playNode.addChild(hard_label)
        
        back.position = CGPoint(x: self.frame.minX + 60, y: self.frame.maxY - 60)
        playNode.addChild(back)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(self.atPoint(location) == self.back) {
                back.texture = SKTexture(imageNamed: "back_button_touched")
                back_touch = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(back_touch && self.atPoint(location) != self.back) {
                back.texture = SKTexture(imageNamed: "back_button")
                back_touch = false
            }
            else if(self.atPoint(location) == self.back && !back_touch) {
                back.texture = SKTexture(imageNamed: "back_button_touched")
                back_touch = true
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(back_touch && self.atPoint(location) == self.back) {
                back.texture = SKTexture(imageNamed: "back_button")
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
        }
    }
}