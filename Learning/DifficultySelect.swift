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
    
    override func didMove(to view: SKView) {
        
        //add children to the parent node because for some reason my positioning was screwing up
        self.addChild(self.parentNode)
        
        easy.fontName = "AvenirNextCondensed-UltraLight"
        easy.fontSize = CGFloat(100.0)
        easy.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 125)
        parentNode.addChild(easy)
        
        medium.fontName = "AvenirNextCondensed-UltraLight"
        medium.fontSize = CGFloat(100.0)
        medium.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 25)
        parentNode.addChild(medium)
        
        hard.fontName = "AvenirNextCondensed-UltraLight"
        hard.fontSize = CGFloat(100.0)
        hard.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 175)
        parentNode.addChild(hard)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(self.atPoint(location) == self.easy) {
                
                if(UserDefaults.standard.integer(forKey: "difficulty") != 2) {
                    UserDefaults.standard.set(2, forKey: "difficulty")
                }
                
                let scene = playScene(size: self.size)
                let skview = self.view!
                skview.ignoresSiblingOrder = true
                scene.scaleMode = .resizeFill
                skview.presentScene(scene)
            }
            
            if(self.atPoint(location) == self.medium) {
                
                if(UserDefaults.standard.integer(forKey: "difficulty") != 3) {
                    UserDefaults.standard.set(3, forKey: "difficulty")
                }
                
                let scene = playScene(size: self.size)
                let skview = self.view!
                skview.ignoresSiblingOrder = true
                scene.scaleMode = .resizeFill
                skview.presentScene(scene)
            }
            
            if(self.atPoint(location) == self.hard) {
                
                if(UserDefaults.standard.integer(forKey: "difficulty") != 4) {
                    UserDefaults.standard.set(4, forKey: "difficulty")
                }
                
                let scene = playScene(size: self.size)
                let skview = self.view!
                skview.ignoresSiblingOrder = true
                scene.scaleMode = .resizeFill
                skview.presentScene(scene)
            }
        }
        
    }
}
