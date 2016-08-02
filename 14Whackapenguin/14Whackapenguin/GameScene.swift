//
//  GameScene.swift
//  14Whackapenguin
//
//  Created by Subramanian, Vishwanath on 8/1/16.
//  Copyright (c) 2016 Vish. All rights reserved.
//

import GameplayKit
import SpriteKit

class GameScene: SKScene {
    
    var gameScore: SKLabelNode!
    var score: Int = 0 {
        
        didSet {
            
            gameScore.text = "Score: \(score)"
        }
    }
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
       let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .Replace
        background.zPosition = -1
        addChild(background)
        
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x:8,y:8)
        gameScore.horizontalAlignmentMode = .Left
        gameScore.fontSize = 48
        addChild(gameScore)
    
    
    
    
    
    
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
