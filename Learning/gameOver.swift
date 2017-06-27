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
    
    override func didMove(to view: SKView) {
        
        menuButton.text = "Back to Menu"
        menuButton.position = CGPoint(x: self.frame.midX - 50, y: self.frame.midY)
        self.addChild(self.menuButton)
        
        playAgain.text = "Play Again"
        playAgain.position = CGPoint(x: self.frame.midX + 50, y: self.frame.midY)
        self.addChild(self.playAgain)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if(self.atPoint(location) == self.menuButton) {
                let scene = GameScene(size: CGSize(width: self.frame.width, height: self.frame.height))
                scene.size = self.size
                let skview = self.view!
                skview.ignoresSiblingOrder = true
                scene.scaleMode = .resizeFill
                skview.presentScene(scene)
            }
            
            else if(self.atPoint(location) == self.playAgain) {
                let scene = playScene(size: CGSize(width: self.frame.width, height: self.frame.height))
                scene.size = self.size
                let skview = self.view!
                skview.ignoresSiblingOrder = true
                scene.scaleMode = .resizeFill
                skview.presentScene(scene, transition: SKTransition.moveIn(with: .down, duration: 1))
            }
        }
    }
}
