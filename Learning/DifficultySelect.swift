//
//  DifficultySelect.swift
//  Learning
//
//  Created by Kevin Zhang on 7/3/17.
//  Copyright © 2017 Kevin Zhang. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class DifficultySelect: SKScene {
    
    private var parentNode = SKNode()
    private var easy = SKLabelNode(text: "Easy")
    private var medium = SKLabelNode(text: "Normal")
    private var hard = SKLabelNode(text: "Hard")
    private var back = SKSpriteNode(imageNamed: "back_button")
    private var back_touch = false
    
    override func didMove(to view: SKView) {
        
        //add children to the parent node because for some reason my positioning was screwing up
        self.addChild(self.parentNode)
        
        easy.fontName = "AvenirNextCondensed-UltraLight"
        easy.fontSize = CGFloat(70.0)
        easy.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 125)
        parentNode.addChild(easy)
        
        medium.fontName = "AvenirNextCondensed-UltraLight"
        medium.fontSize = CGFloat(70.0)
        medium.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 25)
        parentNode.addChild(medium)
        
        hard.fontName = "AvenirNextCondensed-UltraLight"
        hard.fontSize = CGFloat(70.0)
        hard.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 175)
        parentNode.addChild(hard)
        
        back.position = CGPoint(x: self.frame.minX + 60, y: self.frame.maxY - 60)
        parentNode.addChild(back)
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
    
    func presentPlayScene() {
        let scene = playScene(size: self.size)
        let skview = self.view!
        skview.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        skview.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.6))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(self.atPoint(location) == self.easy) {
                UserDefaults.standard.set(2, forKey: "difficulty")
                presentPlayScene()
            }
            
            else if(self.atPoint(location) == self.medium) {
                UserDefaults.standard.set(3, forKey: "difficulty")
                presentPlayScene()
            }
            
            else if(self.atPoint(location) == self.hard) {
                UserDefaults.standard.set(4, forKey: "difficulty")
                presentPlayScene()
            }
            
            else if(back_touch && self.atPoint(location) == self.back) {
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
