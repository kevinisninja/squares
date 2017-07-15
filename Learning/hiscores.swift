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
    private var easy_label = SKLabelNode(text: "Easy: ")
    private var normal_label = SKLabelNode(text: "Normal: ")
    private var hard_label = SKLabelNode(text: "Hard: ")
    
    private var score_easy = SKLabelNode(text: "0")
    private var score_norm = SKLabelNode(text: "0")
    private var score_hard = SKLabelNode(text: "0")
    
    private var easy_back = SKSpriteNode(imageNamed: "dif_select_back")
    private var norm_back = SKSpriteNode(imageNamed: "dif_select_back")
    private var hard_back = SKSpriteNode(imageNamed: "dif_select_back")
    
    private var inf_back = SKSpriteNode(imageNamed: "small_back")
    private var timed_back = SKSpriteNode(imageNamed: "small_back")
    private var infinite = SKLabelNode(text: "∞")
    private var timed = SKLabelNode(text: "Timed")
    
    private var changed = UserDefaults.standard.integer(forKey: "mode_hi")
    
    override func didMove(to view: SKView) {
        self.addChild(self.playNode)
        
        crown.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 150)
        crown.size = CGSize(width: 250.0, height: 250.0)
        playNode.addChild(crown)
        
        easy_label.fontName = "AvenirNextCondensed-UltraLight"
        easy_label.fontSize = CGFloat(70.0)
        easy_label.position = CGPoint(x: self.frame.midX - 90, y: self.frame.midY + 155)
        score_easy.fontName = "AvenirNextCondensed-UltraLight"
        score_easy.fontSize = CGFloat(70.0)
        score_easy.position = CGPoint(x: self.frame.midX + 100, y: self.frame.midY + 150)
        easy_back.position = CGPoint(x: self.frame.midX, y: easy_label.frame.midY + 12)
        easy_back.size = CGSize(width: 475.0, height: 225.0)
        playNode.addChild(easy_back)
        playNode.addChild(easy_label)
        playNode.addChild(score_easy)
        
        normal_label.fontName = "AvenirNextCondensed-UltraLight"
        normal_label.fontSize = CGFloat(70.0)
        normal_label.position = CGPoint(x: self.frame.midX - 56, y: self.frame.midY - 45)
        score_norm.fontName = "AvenirNextCondensed-UltraLight"
        score_norm.fontSize = CGFloat(70.0)
        score_norm.position = CGPoint(x: self.frame.midX + 100, y: self.frame.midY - 50)
        norm_back.position = CGPoint(x: self.frame.midX, y: normal_label.frame.midY)
        norm_back.size = CGSize(width: 475.0, height: 225.0)
        playNode.addChild(norm_back)
        playNode.addChild(normal_label)
        playNode.addChild(score_norm)
        
        hard_label.fontName = "AvenirNextCondensed-UltraLight"
        hard_label.fontSize = CGFloat(70.0)
        hard_label.position = CGPoint(x: self.frame.midX - 82, y: self.frame.midY - 245)
        score_hard.fontName = "AvenirNextCondensed-UltraLight"
        score_hard.fontSize = CGFloat(70.0)
        score_hard.position = CGPoint(x: self.frame.midX + 100, y: self.frame.midY - 250)
        hard_back.position = CGPoint(x: self.frame.midX, y: hard_label.frame.midY)
        hard_back.size = CGSize(width: 475.0, height: 225.0)
        playNode.addChild(hard_back)
        playNode.addChild(hard_label)
        playNode.addChild(score_hard)
        
        back.position = CGPoint(x: self.frame.minX + 60, y: self.frame.maxY - 60)
        back.size = CGSize(width: 150.0, height: 150.0)
        playNode.addChild(back)
        
        infinite.fontName = "AvenirNextCondensed-UltraLight"
        timed.fontName = "AvenirNextCondensed-UltraLight"
        infinite.fontSize = CGFloat(60.0)
        timed.fontSize = CGFloat(50.0)
        infinite.position = CGPoint(x: self.frame.midX - 108, y: easy_back.frame.maxY + 25)
        timed.position = CGPoint(x: self.frame.midX + 108, y: easy_back.frame.maxY + 22)
        inf_back.size = CGSize(width: 222.0, height: 80.0)
        timed_back.size = CGSize(width: 222.0, height: 80.0)
        inf_back.position = CGPoint(x: infinite.frame.midX - 3, y: infinite.frame.midY)
        timed_back.position = CGPoint(x: timed.frame.midX + 3, y: timed.frame.midY - 1)
        
        if(UserDefaults.standard.integer(forKey: "mode_hi") == 0) {
            timed.alpha = 0.5
            timed_back.alpha = 0.5
            inf_back.zPosition = 2
            timed_back.zPosition = 1
            score_easy.text = String(UserDefaults.standard.integer(forKey: "easy_hi"))
            score_norm.text = String(UserDefaults.standard.integer(forKey: "normal_hi"))
            score_hard.text = String(UserDefaults.standard.integer(forKey: "hard_hi"))
        }
        else {
            infinite.alpha = 0.5
            inf_back.alpha = 0.5
            timed_back.zPosition = 2
            inf_back.zPosition = 1
            score_easy.text = String(UserDefaults.standard.integer(forKey: "easy_speed_hi"))
            score_norm.text = String(UserDefaults.standard.integer(forKey: "normal_speed_hi"))
            score_hard.text = String(UserDefaults.standard.integer(forKey: "hard_speed_hi"))
        }
        playNode.addChild(infinite)
        playNode.addChild(timed)
        playNode.addChild(inf_back)
        playNode.addChild(timed_back)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(self.atPoint(location) == self.back) {
                back.alpha = 0.5
                back_touch = true
            }
            else if(self.atPoint(location) == inf_back || self.atPoint(location) == infinite) {
                timed.alpha = 0.5
                timed_back.alpha = 0.5
                inf_back.zPosition = 2
                timed_back.zPosition = 1
                inf_back.alpha = 1.0
                infinite.alpha = 1.0
            }
            else if(self.atPoint(location) == timed_back || self.atPoint(location) == timed) {
                infinite.alpha = 0.5
                inf_back.alpha = 0.5
                timed_back.zPosition = 2
                inf_back.zPosition = 1
                timed_back.alpha = 1.0
                timed.alpha = 1.0
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
            else if(self.atPoint(location) == inf_back || self.atPoint(location) == infinite) {
                timed.alpha = 0.5
                timed_back.alpha = 0.5
                inf_back.zPosition = 2
                timed_back.zPosition = 1
                inf_back.alpha = 1.0
                infinite.alpha = 1.0
                UserDefaults.standard.set(0, forKey: "mode_hi")
            }
            else if(self.atPoint(location) == timed_back || self.atPoint(location) == timed) {
                infinite.alpha = 0.5
                inf_back.alpha = 0.5
                timed_back.zPosition = 2
                inf_back.zPosition = 1
                timed_back.alpha = 1.0
                timed.alpha = 1.0
                UserDefaults.standard.set(1, forKey: "mode_hi")
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
            else if(self.atPoint(location) == inf_back || self.atPoint(location) == infinite) {
                timed.alpha = 0.5
                timed_back.alpha = 0.5
                inf_back.zPosition = 2
                timed_back.zPosition = 1
                inf_back.alpha = 1.0
                infinite.alpha = 1.0
                UserDefaults.standard.set(0, forKey: "mode_hi")
            }
            else if(self.atPoint(location) == timed_back || self.atPoint(location) == timed) {
                infinite.alpha = 0.5
                inf_back.alpha = 0.5
                timed_back.zPosition = 2
                inf_back.zPosition = 1
                timed_back.alpha = 1.0
                timed.alpha = 1.0
                UserDefaults.standard.set(1, forKey: "mode_hi")
            }
        }
        
        if(changed != UserDefaults.standard.integer(forKey: "mode_hi")) {
            
            score_easy.run(SKAction.fadeOut(withDuration: 0.2))
            score_norm.run(SKAction.fadeOut(withDuration: 0.2))
            score_hard.run(SKAction.fadeOut(withDuration: 0.2))
            
            self.run(SKAction.wait(forDuration: 0.2)) {
                if(UserDefaults.standard.integer(forKey: "mode_hi") == 0)
                {
                    self.score_easy.text = String(UserDefaults.standard.integer(forKey: "easy_hi"))
                    self.score_norm.text = String(UserDefaults.standard.integer(forKey: "normal_hi"))
                    self.score_hard.text = String(UserDefaults.standard.integer(forKey: "hard_hi"))
                    self.changed = 0
                }
                else {
                    self.score_easy.text = String(UserDefaults.standard.integer(forKey: "easy_speed_hi"))
                    self.score_norm.text = String(UserDefaults.standard.integer(forKey: "normal_speed_hi"))
                    self.score_hard.text = String(UserDefaults.standard.integer(forKey: "hard_speed_hi"))
                    self.changed = 1
                }
                
                self.score_easy.run(SKAction.fadeIn(withDuration: 0.2))
                self.score_norm.run(SKAction.fadeIn(withDuration: 0.2))
                self.score_hard.run(SKAction.fadeIn(withDuration: 0.2))
            }
        }
    }
}
