//
//  GameViewController.swift
//  20Fireworks
//
//  Created by Subramanian, Vishwanath on 9/15/16.
//  Copyright © 2016 Vish. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // default view controller does not know it has a spritekitview and certainly does not know what scene is showing so we need to do typecasting
    //once we have reference to our actual game scene, we can call explodeFireworks
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        let skView = view as! SKView
        let gameScene = skView.scene as! GameScene
        gameScene.explodeFIreworks()
    }
    
}
