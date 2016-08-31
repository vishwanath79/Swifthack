//
//  GameScene.swift
//  17SwiftyNinja
//
//  Created by Subramanian, Vishwanath on 8/29/16.
//  Copyright (c) 2016 Vish. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var gameScore: SKLabelNode!
    
    var score: Int = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    
    
    var activeSlicePoints = [CGPoint]()
    
    
    // shapenode helps define any kind of shape
    var activeSliceBG: SKShapeNode!
    var activeSliceFG: SKShapeNode!
    
    
    

    
    
    var livesImages = [SKSpriteNode]()
    var lives = 3
    

    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */

        
        let background = SKSpriteNode(imageNamed: "sliceBackground")
        background.position = CGPoint(x:512, y:384)
        background.blendMode = .Replace
        background.zPosition = -1
        addChild(background)
        //vector arrow is pointing straight down
        physicsWorld.gravity = CGVector(dx:0, dy:-6)
        // default gravityis -0.98 using slighlty lower value so objects stay up in the air longer
        physicsWorld.speed = 0.85
        
        createScore()
        createLives()
        createSlices()
        
    
}


func createScore() {
    
    gameScore = SKLabelNode(fontNamed: "Chalkduster")
    gameScore.text = "Score: 0"
    gameScore.horizontalAlignmentMode = .Left
    gameScore.fontSize = 48
    
    addChild(gameScore)
    gameScore.position = CGPoint(x: 8, y: 8)
}


func createLives() {
    
    for i in 0..<3 {
        //adding lives images to the lives images array which is done so we can cross off lives when the player loses
        
        let spriteNode = SKSpriteNode(imageNamed: "slicedLife")
        spriteNode.position = CGPoint(x: CGFloat(834 + (i*70)), y:720)
        addChild(spriteNode)
        livesImages.append(spriteNode)
    }
    
}


func createSlices() {
    //track all player oves on the screen recording an array of all their swipe points
    //draw two slice shapes one i nwhite and one in yellow to make it look like there is a glow
    //use the zposition property to make sure the slices go above everything else in the game
    
    activeSliceBG = SKShapeNode()
    activeSliceBG.zPosition = 2
    
    activeSliceFG = SKShapeNode()
    activeSliceFG.zPosition = 2
    
    activeSliceBG.strokeColor = UIColor(red: 1, green: 0.9, blue: 0, alpha: 1)
    activeSliceBG.lineWidth = 9
    
    activeSliceFG.strokeColor = UIColor.whiteColor()
    activeSliceFG.lineWidth = 5
    
    //note that background slice is thicker than FG so we have to add the background first
    addChild(activeSliceBG)
    addChild(activeSliceFG)
    
    
    
}

    
    func redrawActiveSLice() {
        
        // 1
        
        if activeSlicePoints.count < 2 {
            
            activeSliceBG.path = nil
            activeSliceFG.path = nil
            
            return
            
        }
        
        
        //2
        
        while activeSlicePoints.count > 12 {
            activeSlicePoints.removeAtIndex(0)
        }
        
        
        //3
        
        let path = UIBezierPath()
        path.moveToPoint(activeSlicePoints[0])
        
        for i in 1..< activeSliePoints.count {
            
            path.addLineToPoint(activeSlicePoints[i])
        }
        
        //4
        
        activeSliceBG.path = path.CGPath
        activeSliceFG.path = path.CGPath
        
        
    }
    

override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)
    
    //1 if we have fewer than 2 points in our array, we dont ahve enough data to draw a line so it needsto clear th shapes and exit the method
    
    activeSlicePoints.removeAll(keepCapacity: true)
    
    //2 if we have more than 12 slice points in our array, we need to remove teh oldest ones until we have at most 12
    
    if let touch = touches.first {
        
        let location = touch.locationInNode(self)
        activeSlicePoints.append(location)
        
        
        //3 it needs to start its line at the position of the first swipe point then go through each of the others drawing lines to each point
        
        redrawActiveSlice()
        
        //4 it needs to update the slice shape paths so they get drawn using their designs line width and color
        
        activeSliceBG.removeAllActions()
        activeSliceBG.removeAllActions()
        
        
        
        
        activeSliceBG.alpha = 1
        activeSliceBG.alpha = 1
        
    }
    
}

        override func touchesMoved(touches: Set<UITouch> , withEvent event: UIEvent?) {
            
            guard let touch = touches.first else { return }
            
            let location = touch.locationInNode(self)
            
            activeSlicePoints.append(location)
            
            redrawActiveSlice()
        }


        // when the user finishes touching the screen touchesEnded will be called
        
        override func touchesEnded(touches: Set<UiTouch>?, withEvent event: UIEvent?) {
            
            activeSliceBG.runAction(SKAction.fadeOutWithDuration(0.25))
            activeSliceFG.runAction(SKAction.fadeOutWithDuration(0.25))
        }
        
        
        override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
            
            if let touches = touches {
                
                
                touchesEnded(touches, withEvent: event)
            }
            
        }
        
        
        //touches began needs to remove all existing points in the activeslice points array
        // touches began needs to get the touch location and add it to the activeslicepoints array
        // call the redrawactiveslice method to clear the slice shapes
        // rmeove any actions that are currently attached ot the slice shapes
        //set both slice shapes to have an alpha value of 1 so they are fully visible
        
        


        
        





