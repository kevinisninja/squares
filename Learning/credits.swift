//
//  credits.swift
//  Learning
//
//  Created by Kevin Zhang on 7/11/17.
//  Copyright © 2017 Kevin Zhang. All rights reserved.
//

import Foundation
import SpriteKit

class credits: SKScene {
    
    private var playNode = SKNode()
    private var back = SKSpriteNode(imageNamed: "back_button")
    private var back_touch = false
    private var text1 = SKLabelNode(text: "Thanks for Playing!")
    
    private var text3 = SKLabelNode(text: "Game concept: ")
    private var text3_2 = SKLabelNode(text: "Glaiza-Mae")
    private var text3_3 = SKLabelNode(text: "Sande-Docor")
    
    private var text2 = SKLabelNode(text: "Developed by: ")
    private var text2_2 = SKLabelNode(text: "Kevin Zhang")
    
    private var logo = SKSpriteNode(imageNamed: "better_logo")
    
    override func didMove(to view: SKView) {
        self.addChild(playNode)
        
        text1.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 200)
        text1.fontName = "AvenirNextCondensed-UltraLight"
        text1.fontSize = CGFloat(70.0)
        playNode.addChild(text1)
        
        back.position = CGPoint(x: self.frame.minX + 60, y: self.frame.maxY - 60)
        back.size = CGSize(width: 150.0, height: 150.0)
        playNode.addChild(back)
        
        text2.position = CGPoint(x: self.frame.midX - 120, y: back.frame.midY - 150)
        text2.fontSize = CGFloat(70.0)
        text2.fontName = "AvenirNextCondensed-UltraLight"
        playNode.addChild(text2)
        
        text2_2.position = CGPoint(x: self.frame.midX, y: text2.frame.midY - 100)
        text2_2.fontSize = CGFloat(90.0)
        text2_2.fontName = "AvenirNextCondensed-UltraLight"
        playNode.addChild(text2_2)
        
        text3.position = CGPoint(x: self.frame.midX - 120, y: text2_2.frame.maxY - 200)
        text3.fontSize = CGFloat(70.0)
        text3.fontName = "AvenirNextCondensed-UltraLight"
        playNode.addChild(text3)
        
        text3_2.position = CGPoint(x: self.frame.midX - 60, y: text3.frame.midY - 100)
        text3_2.fontSize = CGFloat(90.0)
        text3_2.fontName = "AvenirNextCondensed-UltraLight"
        playNode.addChild(text3_2)
        
        text3_3.position = CGPoint(x: self.frame.midX + 20, y: text3_2.frame.midY - 110)
        text3_3.fontSize = CGFloat(90.0)
        text3_3.fontName = "AvenirNextCondensed-UltraLight"
        playNode.addChild(text3_3)
        
        logo.size = CGSize(width: 250.0, height: 250.0)
        logo.position = CGPoint(x: self.frame.midX, y: text1.frame.maxY + 200)
        playNode.addChild(logo)
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
                        scene.scaleMode = .aspectFit
                        
                        // Present the scene
                        view.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.6))
                    }
                }
            }
        }
    }

}
