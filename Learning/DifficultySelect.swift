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
    private var easy_touch = false
    private var medium = SKLabelNode(text: "Normal")
    private var medium_touch = false
    private var hard = SKLabelNode(text: "Hard")
    private var hard_touch = false
    private var back = SKSpriteNode(imageNamed: "back_button")
    private var back_touch = false
    
    private var easy_back = SKSpriteNode(imageNamed: "dif_select_back")
    private var norm_back = SKSpriteNode(imageNamed: "dif_select_back")
    private var hard_back = SKSpriteNode(imageNamed: "dif_select_back")
    
    override func didMove(to view: SKView) {
        
        //add children to the parent node because for some reason my positioning was screwing up
        self.addChild(self.parentNode)
        
        easy.fontName = "AvenirNextCondensed-UltraLight"
        easy.fontSize = CGFloat(90.0)
        easy.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 250)
        easy_back.position = CGPoint(x: self.frame.midX, y: easy.frame.midY + 5)
        easy_back.size = CGSize(width: 500.0, height: 250.0)
        parentNode.addChild(easy)
        parentNode.addChild(easy_back)
        
        medium.fontName = "AvenirNextCondensed-UltraLight"
        medium.fontSize = CGFloat(90.0)
        medium.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        norm_back.position = CGPoint(x: self.frame.midX, y: medium.frame.midY)
        norm_back.size = CGSize(width: 500.0, height: 250.0)
        parentNode.addChild(medium)
        parentNode.addChild(norm_back)
        
        hard.fontName = "AvenirNextCondensed-UltraLight"
        hard.fontSize = CGFloat(90.0)
        hard.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 250)
        hard_back.position = CGPoint(x: self.frame.midX, y: hard.frame.midY)
        hard_back.size = CGSize(width: 500.0, height: 250.0)
        parentNode.addChild(hard)
        parentNode.addChild(hard_back)
        
        back.position = CGPoint(x: self.frame.minX + 60, y: self.frame.maxY - 60)
        back.size = CGSize(width: 150.0, height: 150.0)
        parentNode.addChild(back)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(self.atPoint(location) == self.back) {
                back.alpha = 0.5
                back_touch = true
            }
            else if(self.atPoint(location) == self.easy_back) {
                easy.fontColor = UIColor .gray
                easy_back.alpha = 0.5
                easy_touch = true
            }
            else if(self.atPoint(location) == self.norm_back) {
                medium.fontColor = UIColor .gray
                norm_back.alpha = 0.5
                medium_touch = true
            }
            else if(self.atPoint(location) == self.hard_back) {
                hard.fontColor = UIColor .gray
                hard_back.alpha = 0.5
                hard_touch = true
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
            else if(!back_touch && self.atPoint(location) == self.back) {
                back.alpha = 0.5
                back_touch = true
            }
            else if(easy_touch && self.atPoint(location) != self.easy_back) {
                easy.fontColor = UIColor .white
                easy_back.alpha = 1.0
                easy_touch = false
            }
            else if(!easy_touch && self.atPoint(location) == self.easy_back) {
                easy.fontColor = UIColor .gray
                easy_back.alpha = 0.5
                easy_touch = true
            }
            else if(medium_touch && self.atPoint(location) != self.norm_back) {
                medium.fontColor = UIColor .white
                norm_back.alpha = 1.0
                medium_touch = false
            }
            else if(!medium_touch && self.atPoint(location) == self.norm_back) {
                medium.fontColor = UIColor .gray
                norm_back.alpha = 0.5
                medium_touch = true
            }
            else if(hard_touch && self.atPoint(location) != self.hard_back) {
                hard.fontColor = UIColor .white
                hard_back.alpha = 1.0
                hard_touch = false
            }
            else if(!hard_touch && self.atPoint(location) == self.hard_back) {
                hard.fontColor = UIColor .gray
                hard_back.alpha = 0.5
                hard_touch = true
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
            
            if(easy_touch && self.atPoint(location) == self.easy_back) {
                easy.fontColor = UIColor .white
                easy_back.alpha = 1.0
                easy_touch = false
                UserDefaults.standard.set(2, forKey: "difficulty")
                presentPlayScene()
            }
            
            else if(medium_touch && self.atPoint(location) == self.norm_back) {
                medium.fontColor = UIColor .white
                norm_back.alpha = 1.0
                medium_touch = false
                UserDefaults.standard.set(3, forKey: "difficulty")
                presentPlayScene()
            }
            
            else if(hard_touch && self.atPoint(location) == self.hard_back) {
                hard.fontColor = UIColor .white
                hard_back.alpha = 1.0
                hard_touch = false
                UserDefaults.standard.set(4, forKey: "difficulty")
                presentPlayScene()
            }
            
            else if(back_touch && self.atPoint(location) == self.back) {
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
