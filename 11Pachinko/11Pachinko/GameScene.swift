//
//  GameScene.swift
//  11Pachinko
//
//  Created by Subramanian, Vishwanath on 7/18/16.
//  Copyright (c) 2016 Vish. All rights reserved.
//

import SpriteKit

    //make the class conform to SKPhysicsContactDelegate property for collision detection
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //SkLabelNode is similar to UIlabel
    var scoreLabel: SKLabelNode!
    
    var score: Int = 0 {
        
        didSet {
            
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    
    
    
    override func didMoveToView(view: SKView) {
        
        
        /* Setup your scene here */
     let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .Replace
        background.zPosition = -1
        addChild(background)
        // adds a physics body to the whole scene  that is a line on each edge, effectively acting as a container for the scene
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        
        // Assing the current scene to be the physicss world's contact delegate
        physicsWorld.contactDelegate = self
        
        makeSlotAt(CGPoint(x: 128, y:0), isGood: true)
        makeSlotAt(CGPoint(x: 384, y:0), isGood: false)
        makeSlotAt(CGPoint(x: 640, y:0), isGood: true)
        makeSlotAt(CGPoint(x: 896, y:0), isGood: false)
        
        
        
        
        
        makeBouncerAt(CGPoint(x:0, y:0))
        makeBouncerAt(CGPoint(x:256, y:0))
        makeBouncerAt(CGPoint(x:512, y:0))
        makeBouncerAt(CGPoint(x:768, y:0))
        makeBouncerAt(CGPoint(x:1024, y:0))
        
        
        // place score label into the scene and property observer automatically updates the label as the score value changes
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .Right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            //let box = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 64, height: 64))
            // Adds a physics body to the box that is a rectangle same size as the box
            //box.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 64, height: 64))
            //box.position = location
            //addChild(box)
            
            let ball = SKSpriteNode(imageNamed: "ballRed")
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
            
            //contacttestbitmask means which nodes should i bump into and whihc collisions do you want to know about
            //collisonbitmask indicates tell me about every collission
            ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
            
            // restitution (bounciness) level of 0.4
            ball.physicsBody!.restitution = 0.4
            ball.position = location
            
            ball.name = "ball"
            
            addChild(ball)
            
        }
        
    
    }
    
    //setting up the scene to be the contact delegate of the physics world
    //we need to change the contactTestBitMask property of our physics objects which sets the contactDelegate property to be our scene

    
    
    
    
    // whether the slot is good or not and which image gets loaded
    func makeSlotAt(position: CGPoint, isGood: Bool) {
        
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            
            // need to have three names in our code: good slots, bad slots and balls
            
            slotBase.name = "good"
            
        } else {
            
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        
        //add rectangle physics to slots
        slotBase.physicsBody = SKPhysicsBody(rectangleOfSize: slotBase.size)
        //slotbase needs to be non-dynamic because we dont want it to move out of the way when a player ball hits
        slotBase.physicsBody!.dynamic = false
        
        
        addChild(slotBase)
        addChild(slotGlow)
        
        
        // angels are specified in radians not degrees. pi radians = 180 degrees
        //Built in value of pi called M_PI
        //Have to use CGFLoat with M_PI
        //WHen you create an action it will run once , if you want it to run forever, you create another action to wrap the first one using repeatActionForever()
        
        let spin = SKAction.rotateByAngle(CGFloat(M_PI_2), duration: 10)
        let spinForever = SKAction.repeatActionForever(spin)
        slotGlow.runAction(spinForever)
        
        
        
    }
    
    
    func makeBouncerAt(position: CGPoint) {
        
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
          // spritekits positions start from the center of the nodes so x:512 y: 0 means centered horizontally on the bottom edge of the scene
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0 )
        
        bouncer.physicsBody!.contactTestBitMask = bouncer.physicsBody!.collisionBitMask
        
        bouncer.physicsBody!.dynamic = false
        addChild(bouncer)
    }
    
   
    func collisionBetweenBall(ball: SKNode, object: SKNode) {
        
        if object.name == "good" {
            destroyBall(ball)
            //to modify the player score
            score += 1
            
        } else if object.name == "bad" {
            
            destroyBall(ball)
            score -= 1
        }

        
    }
    
    func destroyBall(ball: SKNode) {
        //removes a node from your node tree or removes node form your game
        ball.removeFromParent()
    }
    
    
    //for contact checking
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.node!.name == "ball" {
            
            collisionBetweenBall(contact.bodyA.node!, object: contact.bodyB.node!)
        } else if contact.bodyB.node!.name == "ball" {
            
            collisionBetweenBall(contact.bodyB.node!, object: contact.bodyA.node!)
        }
    }
    
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    
    
    
    
    }
    
    
    
    
}
