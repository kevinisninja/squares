//
//  settings.swift
//  Learning
//
//  Created by Kevin Zhang on 7/11/17.
//  Copyright © 2017 Kevin Zhang. All rights reserved.
//

import Foundation
import SpriteKit

class settings: SKScene {
    
    private var playNode = SKNode()
    private var back = SKSpriteNode(imageNamed: "back_button")
    private var back_touch = false
    
    private var animation_speed = SKLabelNode(text: "Animation speed: ")
    private var speed_1x = SKLabelNode(text: "Normal")
    private var speed_2x = SKLabelNode(text: "Fast")
    
    private var sound = SKLabelNode(text: "Sound Effects: ")
    private var sound_on = SKLabelNode(text: "On")
    private var sound_off = SKLabelNode(text: "Off")

    
    override func didMove(to view: SKView) {
        self.addChild(playNode)
        
        animation_speed.fontName = "AvenirNextCondensed-UltraLight"
        speed_1x.fontName = "AvenirNextCondensed-UltraLight"
        speed_2x.fontName = "AvenirNextCondensed-UltraLight"
        sound.fontName = "AvenirNextCondensed-UltraLight"
        sound_on.fontName = "AvenirNextCondensed-UltraLight"
        sound_off.fontName = "AvenirNextCondensed-UltraLight"
        
        animation_speed.fontSize = CGFloat(90.0)
        sound.fontSize = CGFloat(90.0)
        
        speed_1x.fontSize = CGFloat(110.0)
        speed_2x.fontSize = CGFloat(110.0)
        sound_on.fontSize = CGFloat(110.0)
        sound_off.fontSize = CGFloat(90.0)
        
        back.position = CGPoint(x: self.frame.minX + 60, y: self.frame.maxY - 60)
        back.size = CGSize(width: 150.0, height: 150.0)
        playNode.addChild(back)
        
        animation_speed.position = CGPoint(x: self.frame.midX, y: back.frame.midY - 300)
        playNode.addChild(animation_speed)
        
        speed_1x.position = CGPoint(x: self.frame.midX - 100, y: animation_speed.frame.midY - 120)
        speed_2x.position = CGPoint(x: self.frame.midX + 100, y: animation_speed.frame.midY - 120)
        
        if(UserDefaults.standard.integer(forKey: "animation_speed") == 0) {
            speed_2x.alpha = 0.5
        }
        else {
            speed_1x.alpha = 0.5
        }
        playNode.addChild(speed_1x)
        playNode.addChild(speed_2x)
        
        sound.position = CGPoint(x: self.frame.midX, y: speed_1x.frame.midY - 250)
        playNode.addChild(sound)
        
        sound_on.position = CGPoint(x: self.frame.midX - 100, y: sound.frame.midY - 120)
        sound_off.position = CGPoint(x: self.frame.midX + 100, y: sound.frame.midY - 120)
        
        if(UserDefaults.standard.bool(forKey: "sound_off") == false)
        {
            sound_off.alpha = 0.5
        }
        else {
            sound_on.alpha = 0.5
        }
        
        playNode.addChild(sound_on)
        playNode.addChild(sound_off)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(self.atPoint(location) == self.back) {
                back.alpha = 0.5
                back_touch = true
            }
            else if(self.atPoint(location) == self.speed_1x) {
                speed_1x.alpha = 1.0
                speed_2x.alpha = 0.5
            }
            else if(self.atPoint(location) == self.speed_2x) {
                speed_2x.alpha = 1.0
                speed_1x.alpha = 0.5
            }
            else if(self.atPoint(location) == self.sound_on) {
                sound_on.alpha = 1.0
                sound_off.alpha = 0.5
            }
            else if(self.atPoint(location) == self.sound_off) {
                sound_off.alpha = 1.0
                sound_on.alpha = 0.5
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
            else if(self.atPoint(location) == self.speed_1x) {
                speed_1x.alpha = 1.0
                speed_2x.alpha = 0.5
            }
            else if(self.atPoint(location) == self.speed_2x) {
                speed_2x.alpha = 1.0
                speed_1x.alpha = 0.5
            }
            else if(self.atPoint(location) == self.sound_on) {
                sound_on.alpha = 1.0
                sound_off.alpha = 0.5
            }
            else if(self.atPoint(location) == self.sound_off) {
                sound_off.alpha = 1.0
                sound_on.alpha = 0.5
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
            else if(self.atPoint(location) == self.speed_1x) {
                speed_1x.alpha = 1.0
                speed_2x.alpha = 0.5
                UserDefaults.standard.set(0, forKey: "animation_speed")
            }
            else if(self.atPoint(location) == self.speed_2x) {
                speed_2x.alpha = 1.0
                speed_1x.alpha = 0.5
                UserDefaults.standard.set(1, forKey: "animation_speed")
            }
            else if(self.atPoint(location) == self.sound_on) {
                sound_on.alpha = 1.0
                sound_off.alpha = 0.5
                UserDefaults.standard.set(false, forKey: "sound_off")
            }
            else if(self.atPoint(location) == self.sound_off) {
                sound_off.alpha = 1.0
                sound_on.alpha = 0.5
                UserDefaults.standard.set(true, forKey: "sound_off")
            }
        }
    }
}
