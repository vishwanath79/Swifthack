//
//  GameScene.swift
//  11Pachinko
//
//  Created by Subramanian, Vishwanath on 7/18/16.
//  Copyright (c) 2016 Vish. All rights reserved.
//

import SpriteKit
import GameplayKit

    //make the class conform to SKPhysicsContactDelegate property for collision detection
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //SkLabelNode is similar to UIlabel
    var scoreLabel: SKLabelNode!
    
    var editLabel: SKLabelNode!
    
    var editingMode: Bool = false {
        
        //place obstacles on top of the scene and the slots at the bottom so that players have to position the balls exactly

        didSet {
            
            if editingMode {
                
                editLabel.text = "Done"
            }
            
            else {
                
                editLabel.text = "Edit"
            }
            
        }
    }
    
    
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
        
        
        //add label to top right of the screen
        //using property observer to automatically change the editing labels text when edit mode is changed
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        // what is new is detecting whether the user tapped the edit/done button or is trying to create a ball
        //To make this work we are going to ask spritekit to give us a list of all nodes at the point that was tapped and check if it contains our edit label
        // if it does we flip the value of our editingmode boolean, else execute previous ball creation mode
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            //let box = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 64, height: 64))
            // Adds a physics body to the box that is a rectangle same size as the box
            //box.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 64, height: 64))
            //box.position = location
            //addChild(box)
            
            let objects = nodesAtPoint(location) as [SKNode]
            
            if objects.contains(editLabel) {
                //this means set editing mode to be the oppossite of what its right now
                editingMode = !editingMode
                
            } else {
                
                if editingMode {
                    //create a box
                    let size = CGSize(width: GKRandomDistribution(lowestValue: 16, highestValue: 128).nextInt(), height: 16)
                    let box = SKSpriteNode(color: RandomColor(), size: size)
                    box.zRotation = RandomCGFloat(min: 0, max: 3)
                    box.position = location
                    box.physicsBody = SKPhysicsBody(rectangleOfSize: box.size)
                    box.physicsBody!.dynamic = false
                    
                    addChild(box)
                } else {
                    
                //createa ball
                

                    
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
            
    }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
    
    
    
    //setting up the scene to be the contact delegate of the physics world
    //we need to change the contactTestBitMask property of our physics objects which sets the contactDelegate property to be our scene

    
    func makeBouncerAt(position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody!.contactTestBitMask = bouncer.physicsBody!.collisionBitMask
        bouncer.physicsBody!.dynamic = false
        addChild(bouncer)
    }
    
    func makeSlotAt(position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOfSize: slotBase.size)
        slotBase.physicsBody!.dynamic = false
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotateByAngle(CGFloat(M_PI_2), duration: 10)
        let spinForever = SKAction.repeatActionForever(spin)
        slotGlow.runAction(spinForever)
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
        
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
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
    
    
    


    
    
}
