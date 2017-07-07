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
    private var easy_label = SKLabelNode(text: "Easy: " + String(UserDefaults.standard.integer(forKey: "easy_hi")))
    private var normal_label = SKLabelNode(text: "Normal: " + String(UserDefaults.standard.integer(forKey: "normal_hi")))
    private var hard_label = SKLabelNode(text: "Hard: " + String(UserDefaults.standard.integer(forKey: "hard_hi")))
    
    override func didMove(to view: SKView) {
        self.addChild(self.playNode)
        
        crown.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 200)
        playNode.addChild(crown)
        
        easy_label.fontName = "AvenirNextCondensed-UltraLight"
        easy_label.fontSize = CGFloat(70.0)
        easy_label.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 300)
        playNode.addChild(easy_label)
        
        normal_label.fontName = "AvenirNextCondensed-UltraLight"
        normal_label.fontSize = CGFloat(70.0)
        normal_label.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
        playNode.addChild(normal_label)
        
        hard_label.fontName = "AvenirNextCondensed-UltraLight"
        hard_label.fontSize = CGFloat(70.0)
        hard_label.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        playNode.addChild(hard_label)
        
        back.position = CGPoint(x: self.frame.minX + 60, y: self.frame.maxY - 60)
        playNode.addChild(back)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(self.atPoint(location) == self.back) {
                back.alpha = 0.5
                back_touch = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(back_touch && self.atPoint(location) != self.back) {
                back.alpha = 1.0
                back_touch = false
            }
            else if(self.atPoint(location) == self.back && !back_touch) {
                back.alpha = 0.5
                back_touch = true
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(back_touch && self.atPoint(location) == self.back) {
                back.alpha = 1.0
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
