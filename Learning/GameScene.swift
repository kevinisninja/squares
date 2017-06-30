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
        
        add_images()

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            
            if self.atPoint(location) == self.playButton {
                let transition = SKAction.animate(with: animateBackground, timePerFrame: 0.005)
                
                let scene = playScene(size: self.size)
                let skview = self.view!
                skview.ignoresSiblingOrder = true
                scene.scaleMode = .resizeFill
                
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
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_18")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_19")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_20")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_21")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_22")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_23")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_24")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_25")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_26")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_27")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_28")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_29")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_30")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_31")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_32")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_33")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_34")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_35")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_36")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_37")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_38")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_39")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_40")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_41")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_42")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_43")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_44")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_45")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_46")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_47")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_48")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_49")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_50")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_51")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_52")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_53")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_54")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_55")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_56")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_57")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_58")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_59")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_60")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_61")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_62")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_63")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_64")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_65")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_66")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_67")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_68")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_69")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_70")))
        animateBackground.append(SKTexture(image: #imageLiteral(resourceName: "background_trans_final")))
    }
}
