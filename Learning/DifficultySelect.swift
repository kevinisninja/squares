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
    private var background = SKSpriteNode(imageNamed: "background_trans_final")
    private var easy = SKSpriteNode(imageNamed: "easy")
    private var medium = SKSpriteNode(imageNamed: "easy")
    private var hard = SKSpriteNode(imageNamed: "easy")
    private var extreme = SKSpriteNode(imageNamed: "easy")
    
    override func didMove(to view: SKView) {
        
        //add children to the parent node because for some reason my positioning was screwing up
        self.addChild(self.parentNode)
        
        //initialize the background
        background.size = self.size
        background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        background.zPosition = 1
        parentNode.addChild(self.background)
        
        //initialize difficulty buttons
        easy.zPosition = 2
        easy.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        parentNode.addChild(self.easy)
        
        medium.zPosition = 2
        medium.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        parentNode.addChild(self.medium)
        
        hard.zPosition = 2
        hard.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 150)
        parentNode.addChild(self.hard)
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
