//
//  GameScene.swift
//  11Pachinko
//
//  Created by Subramanian, Vishwanath on 7/18/16.
//  Copyright (c) 2016 Vish. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
     let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .Replace
        background.zPosition = -1
        addChild(background)
        // adds a physics body to the whole scene  that is a line on each edge, effectively acting as a container for the scene
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)

        makeBouncerAt(CGPoint(x:0, y:0))
        makeBouncerAt(CGPoint(x:256, y:0))
        makeBouncerAt(CGPoint(x:512, y:0))
        makeBouncerAt(CGPoint(x:768, y:0))
        makeBouncerAt(CGPoint(x:1024, y:0))
        
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
            // restitution (bounciness) level of 0.4
            ball.physicsBody!.restitution = 0.4
            ball.position = location
            addChild(ball)
            
        }
        
    
    }
    
    
    func makeBouncerAt(position: CGPoint) {
        
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
          // spritekits positions start from the center of the nodes so x:512 y: 0 means centered horizontally on the bottom edge of the scene
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0 )
        bouncer.physicsBody!.dynamic = false
        addChild(bouncer)
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    
    
    
    
    }
    
    
    
    
}
