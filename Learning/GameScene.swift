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

    private var playNode = SKNode()
    private let playButton = SKSpriteNode(imageNamed:"play")
    private var background = SKSpriteNode(imageNamed: "background")
    private var title = SKLabelNode(text: "Squares")
    private var animateBackground = [SKTexture]()
    
    override func didMove(to view: SKView) {
        self.addChild(self.playNode)
        
        self.background.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.background.size = self.size
        self.background.zPosition = 1
        playNode.addChild(self.background)
        
        title.fontName = "Heiti SC"
        title.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 300)
        title.fontSize = CGFloat(150.0)
        title.zPosition = 2
        playNode.addChild(self.title)
        
        self.playButton.position = CGPoint(x: self.frame.midX - 50, y: self.frame.midY + 30)
        self.playButton.size = CGSize(width: 250, height: 250)
        self.playButton.zPosition = 2
        playNode.addChild(self.playButton)
        
        add_images()

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if self.atPoint(location) == self.playButton {
                let transition = SKAction.animate(with: animateBackground, timePerFrame: 0.015)
                
                let scene = DifficultySelect(size: self.size)
                let skview = self.view!
                skview.ignoresSiblingOrder = true
                scene.scaleMode = .resizeFill
                
                title.removeFromParent()
                playButton.removeFromParent()
                background.run(transition)
                {
                    skview.presentScene(scene)
                }
            }
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func add_images() {
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_1")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_4")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_7")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_10")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_13")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_16")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_19")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_22")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_27")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_30")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_33")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_36")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_39")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_42")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_45")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_48")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_51")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_54")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_57")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_60")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_63")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_66")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_69")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_final")))
    }
}
