//
//  stats.swift
//  Learning
//
//  Created by Kevin Zhang on 7/5/17.
//  Copyright © 2017 Kevin Zhang. All rights reserved.
//

import Foundation
import SpriteKit

class instructions: SKScene {
    
    private var playNode = SKNode()
    private var back = SKSpriteNode(imageNamed: "back_button")
    private var back_touch = false
    
    override func didMove(to view: SKView) {
        self.addChild(playNode)
        
        
        back.position = CGPoint(x: self.frame.minX + 60, y: self.frame.maxY - 60)
        back.size = CGSize(width: 150.0, height: 150.0)
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
