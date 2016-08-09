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
    var numRounds = 0
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
        
        
        RunAfterDelay(1) {
            [unowned self] in
            self.createEnemy()
        }
    
    }
    
    
    func createEnemy() {
        
        //will decrease popuptime each times its called
        // shuffle the list of available slots using the gameplaykit shuffle that we've used previously
        // make the first slot show itself, passing in the current value of popuptime for the method to use later
        // generate the four random numbers to see if more slots should be shown. potentially up to 5 slots could be shown at once
        // call itself again after a random delay. delay will be between popuptime halved and popuptime doubled.
        // use the *= operator to multiply and assing at the same time
        // use the randomdouble function to genreate a random double value
        popupTime *= 0.991
        
        slots = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(slots) as! [WhackSlot]
        numRounds += 1
        
        if numRounds >= 30 {
            
            for slot in slots {
                
                slot.hide()
            }
            
            
            let gameOver = SKSpriteNode(imageNamed: "gameOver")
            gameOver.position = CGPoint(x:512, y:384)
            gameOver.zPosition = 1
            addChild(gameOver)
            
            return
            
        }
        
        slots[0].show(hideTime: popupTime)
        
        if RandomInt(min: 0, max: 12) > 4 { slots[1].show(hideTime: popupTime) }
        if RandomInt(min: 0, max: 12) > 8 { slots[2].show(hideTime: popupTime) }
        if RandomInt(min: 0, max: 12) > 10 { slots[3].show(hideTime: popupTime) }
        if RandomInt(min: 0, max: 12) > 11 { slots[4].show(hideTime: popupTime) }

        let minDelay = popupTime / 2.0
        let maxDelay = popupTime * 2
        
        
        RunAfterDelay(RandomDouble(min: minDelay, max: maxDelay)) { [unowned self] in
            
            self.createEnemy()
        
    }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        if let touch = touches.first {
            
            let location = touch.locationInNode(self)
            let nodes = nodesAtPoint(location)
            
            for node in nodes {
                
                if node.name == "charFriend" {
                    
                    //they should not have whacked this penguin, when this happens call the hit method to make the penguin hidei tself, subtract 5 from the current score and run an action that plays bad hit sound
                    let whackSlot = node.parent!.parent as! WhackSlot
                    
                    if !whackSlot.visible { continue }
                    
                    if whackSlot.isHit { continue }
                    
                    whackSlot.hit()
                    score -= 5
                    
                    runAction(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion: false))
                }
                
                else if node.name == "charEnemy" {
                    
                    //they should have whacked this one, we want to add 1 to the score
                    let whackSlot = node.parent!.parent as! WhackSlot
                    if !whackSlot.visible { continue }
                    if !whackSlot.isHit { continue }
                    whackSlot.charNode.xScale = 0.85
                    whackSlot.charNode.yScale = 0.85
                    whackSlot.hit()
                    score += 1
                    
                    runAction(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
                    
        
                    
                }
            }
            
            
        }

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
