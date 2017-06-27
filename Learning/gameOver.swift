//
//  gameOver.swift
//  Learning
//
//  Created by Kevin Zhang on 6/22/17.
//  Copyright © 2017 Kevin Zhang. All rights reserved.
//

import Foundation
import SpriteKit

class gameOver: SKScene {
    
    private var menuButton = SKLabelNode(text: "Back to Menu")
    private var playAgain = SKLabelNode(text: "Play Again")
    private var background = SKSpriteNode(imageNamed: "background_trans_final")
    
    override func didMove(to view: SKView) {
        
        self.background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.background.zPosition = 1
        self.addChild(self.background)
        
        menuButton.text = "Back to Menu"
        menuButton.position = CGPoint(x: self.frame.midX - 100, y: self.frame.midY)
        self.menuButton.zPosition = 2
        self.addChild(self.menuButton)
        
        playAgain.text = "Play Again"
        playAgain.position = CGPoint(x: self.frame.midX + 100, y: self.frame.midY)
        self.playAgain.zPosition = 2
        self.addChild(self.playAgain)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(self.atPoint(location) == self.menuButton) {
                if let view = self.view as! SKView? {
                    // Load the SKScene from 'GameScene.sks'
                    if let scene = SKScene(fileNamed: "GameScene") {
                        // Set the scale mode to scale to fit the window
                        
                        // Present the scene
                        view.presentScene(scene)
                    }
                }
            }
            
            else if(self.atPoint(location) == self.playAgain) {
                let scene = playScene(size: self.size)
                let skview = self.view!
                skview.ignoresSiblingOrder = true
                scene.scaleMode = .aspectFit
                skview.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.25))
            }
        }
    }
}
