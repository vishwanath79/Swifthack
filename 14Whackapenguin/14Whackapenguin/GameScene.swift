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
    var slots = [WhackSlot]()
    var popupTime = 0.85
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
    
    
        // four loops that call createSlotAt()
        
        for i in 0 ..< 5 { createSlotAt(CGPoint(x: 100 + (i*170), y: 410)) }
        for i in 0 ..< 4 { createSlotAt(CGPoint(x: 180 + (i*170), y: 320)) }
        for i in 0 ..< 5 { createSlotAt(CGPoint(x: 100 + (i*170), y: 230)) }
        for i in 0 ..< 4 { createSlotAt(CGPoint(x: 180 + (i*170), y: 140)) }
    
        // going to call createEnemy() after a delay
        // requires a new grand central dispatch code
        //dispatch_time() is used to create values for a delay and dispatch_after() is used to schedule a closure to execute after the time has been reached
        
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        

    }
   
    func createSlotAt(pos: CGPoint) {
        let slot = WhackSlot()
        slot.configureAtPosition(pos)
        addChild(slot)
        slots.append(slot)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
