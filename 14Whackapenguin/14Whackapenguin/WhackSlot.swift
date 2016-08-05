//
//  WhackSlot.swift
//  14Whackapenguin
//
//  Created by Subramanian, Vishwanath on 8/1/16.
//  Copyright © 2016 Vish. All rights reserved.
//
import SpriteKit
import UIKit

class WhackSlot: SKNode {
    
    var visible = false
    var isHit = false
    
    
    var charNode: SKSpriteNode!
    // add a hole at its current position
    
    // we want to create 4 rows of slots with five slots at the top row and thenfour in the second and then five then four.
    // for slots we need to create A) an array in which we can store all oour slots for referencing later b) a createSlotAt() method that handles slot creation c) Four loops, one for each row
    // for A
    // var slots = [WhackSlot]() in gamescene
    // for B we need to create a method that accepts a position, then creates a whackslot object, calls its configureAtPosition() method then adds the slot both to the scene and to our 
    //B in gamescene
    
    func configureAtPosition(pos: CGPoint) {
        
        position = pos
        
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        
        //by default nodes dont crop. We need to crop the node to hide our penguins. Easiest way is to have a cropmask shaped like the hole that makes the penguin when it moves outside the mask
        // If you give SKCropNode nil mask, it will stop crop node from doing anything
        
        let cropNode = SKCropNode()
        // position cropnode higher than teh slot itself
        cropNode.position = CGPoint(x:0, y: 15)
        //zposition value of 1 puts it in front of other nodes stops it from appearing behind the hole
        cropNode.zPosition = 1
        
        //cropNode.maskNode = nil if u want them invisible
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        //charnode crated with blue good pengiun
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        //-90 means way below the hole as if the pengiun were properly hiding
        charNode.position = CGPoint(x:0, y:-90)
        charNode.name = "character"
        //charode is added to cropNode and crop Node is added to the slot
        cropNode.addChild(charNode)
        addChild(cropNode)
    }
    

    //showing a penguin to be tapped on will be handled by show
    //will make the charater slide upwards so it becomes visible then set visible = true and hit to be false
    //movement is going to be created by a new SKAction called moveByX(_:y:duration:)
    //can change the image inside our penguin sprite by changing its texture property
    func show(hideTime hideTime: Double) {
        
        if visible { return }
        // show method is going to be triggered by the view controller on a recurring basis managed by property popuptime
        charNode.runAction(SKAction.moveByX(0, y: 80, duration: 0.05))
        visible = true
        isHit = false
        
        if RandomInt(min: 0, max: 2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        
        RunAfterDelay(hideTime * 3.5) { [unowned self] in
            self.hide()
            
            
        }
       
        
    }
    
    func hide() {
        if !visible { return}
        
        charNode.runAction(SKAction.moveByX(0, y: -80, duration: 0.05))
        visible = false
    }
    
    
    
    
    
    
}
