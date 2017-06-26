//
//  GameScene.swift
//  Learning
//
//  Created by Kevin Zhang on 6/5/17.
//  Copyright © 2017 Kevin Zhang. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private let playButton = SKSpriteNode(imageNamed:"play")
    private var background = SKSpriteNode(imageNamed: "background")
    private var animateBackground = [SKTexture]()
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor .white
        self.background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.background.zPosition = 1
        self.addChild(self.background)
        self.playButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.playButton.zPosition = 2
        self.addChild(self.playButton)
        
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_1")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_2")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_3")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_4")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_5")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_6")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_7")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_8")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_9")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_10")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_11")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_12")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_13")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_14")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_15")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_16")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_17")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_final")))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if self.atPoint(location) == self.playButton {
                let transition = SKAction.animate(with: animateBackground, timePerFrame: 0.01)
                
                let scene = playScene(size: self.size)
                let skview = self.view!
                skview.ignoresSiblingOrder = true
                scene.scaleMode = .resizeFill
                
                background.run(transition) {
                    skview.presentScene(scene)
                }
            }
            
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
