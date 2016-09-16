//
//  GameScene.swift
//  20Fireworks
//
//  Created by Subramanian, Vishwanath on 9/15/16.
//  Copyright © 2016 Vish. All rights reserved.
//

import SpriteKit
import GameplayKit


var gameTimer: Timer!
var fireworks = [SKNode]()

let leftEdge = -22
let bottomEdge = -22
let rightEdge = 1024 + 22

var score: Int = 0 {
didSet {
    
    //
}
}



class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(launchFireworks), userInfo: nil, repeats: true)
    }
    


    func createFirework(xMovement: CGFloat, x:Int, y: Int) {
        // create an SKNOde that will act as a firework container and place it at the position that was specified
        let node = SKNode()
        node.position  = CGPoint(x:x, y:y)
        
        // create a rocket sprite node give it the name "firework" so we know that its the import thing then add it to container node
        let firework = SKSpriteNode(imageNamed: "rocket")
        firework.name = "firework"
        node.addChild(firework)
        // give firework sprite node one of three random colors: cyan, green or red
        switch GKRandomSource.sharedRandom().nextInt(upperBound: 3) {
        case 0:
            firework.color = .cyan
            firework.colorBlendFactor = 1
            
        case 1:
            firework.color = .green
            firework.colorBlendFactor = 1
            
        case 2:
            firework.color = .red
            firework.colorBlendFactor = 1
            
        default:
            break
        }
        // create  UIBezier path that will represent the movement of the firework
        let path = UIBezierPath()
        path.move(to: CGPoint(x: xMovement, y: 1000))
        //tell the container to follow that path turning itself as needed
        let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
        node.run(move)
        
        
        // create particles behind the rocket to make it look like fireworks are lit
        let emitter = SKEmitterNode(fileNamed: "fuse")!
        emitter.position = CGPoint(x: 0, y: -22)
        node.addChild(emitter)
        //add the firework to our fireworks array and also to the scene
        fireworks.append(node)
        addChild(node)
        
    }
    
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
