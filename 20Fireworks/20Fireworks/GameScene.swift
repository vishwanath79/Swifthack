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
    
    func launchFireworks() {
        // each firework is fired from different positions so that you get a nice spread on the screen
        let movementAmount: CGFloat = 1800
        
        switch GKRandomSource.sharedRandom().nextInt(upperBound: 4) {
        case 0 :
            //fire five straight up
            createFirework(xMovement: 0, x: 512, y: bottomEdge)
            createFirework(xMovement: 0, x: 512 - 200, y: bottomEdge)
            createFirework(xMovement: 0, x: 512 - 100, y: bottomEdge)
            createFirework(xMovement: 0, x: 512 + 100, y: bottomEdge)
            createFirework(xMovement: 0, x: 512 + 200, y: bottomEdge)
            
            
        case 1:
            // fire five, in a fan
            createFirework(xMovement: 0, x: 512, y: bottomEdge)
            createFirework(xMovement: -200, x: 512 - 200, y: bottomEdge)
            createFirework(xMovement: -100, x: 512 - 100, y: bottomEdge)
            createFirework(xMovement: 100, x: 512 + 100, y: bottomEdge)
            createFirework(xMovement: 200, x: 512 + 200, y: bottomEdge)
            
        case 2:
            // fire five, from the left to the right
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 400)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 300)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 200)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 100)
            createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge)
            
        case 3:
            // fire five, from the right to the left
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 400)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 300)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 200)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 100)
            createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge)
            
        default:
            break
            
        }
        
    }
    
    func checkTouches(_ touches: Set<UITouch>) {
        guard let touch = touches.first else {return}
        
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)
        
        for node in nodesAtPoint {
            
            for node in nodesAtPoint {
                if node is SKSpriteNode {
                    let sprite = node as! SKSpriteNode
                    
                    if sprite.name == "firework" {
                        
                        for parent in fireworks {
                            
                            let firework = parent.children[0] as! SKSpriteNode
                            if firework.name == "selected" && firework.color != sprite.color {
                                firework.name = "firwork"
                                firework.colorBlendFactor = 1
                            }
                        }
                        
                        sprite.name = "selected"
                        sprite.colorBlendFactor = 0
                    }
                }
            }
        }
    }
    
    
    
    func explode(firework: SKNode) {
        //creates an explosion where the firework was and then removes the firework from the game scene
        let emitter = SKEmitterNode(fileNamed: "explode")!
        emitter.position = firework.position
        addChild(emitter)
        firework.removeFromParent()
    }
    
    
    //fireworks array stores the firework container node so we need to read the firework image out of its children array
    func explodeFIreworks() {
        var numExploded = 0
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
    super.touchesMoved(touches, with: event)
        checkTouches(touches)
        }

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        checkTouches(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        for (index, firework) in fireworks.enumerated().reversed() {
            if firework.position.y > 900 {
                //this uses a position high above so that rockets can explode off screen
                fireworks.remove(at: index)
                firework.removeFromParent()
            }
        }
    }
}
