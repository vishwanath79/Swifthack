//
//  ViewController.swift
//  7Swiftywords
//
//  Created by Subramanian, Vishwanath on 7/3/16.
//  Copyright © 2016 Vish. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet var cluesLabel: UILabel!
    
    @IBOutlet var answersLabel: UILabel!
    
    
    @IBOutlet var currentAnswer: UITextField!
    
    @IBOutlet var scoreLabel: UILabel!
    
    @IBAction func submitTrapped(sender: AnyObject) {
    }
    
    
    @IBAction func clearTapped(sender: AnyObject) {
    }
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0
    var level = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for subview in view.subviews where subview.tag == 1001 {
            let btn = subview as! UIButton
            letterButtons.append(btn)
            btn.addTarget(self, action: #selector(letterTapped),forControlEvents: .TouchUpInside)
        }
        
        loadLevel()
    }

    
    func loadLevel() {
    
    var clueString = ""
    var solutionString = ""
    var letterBits = [String]()
    
        if let levelFilePath = NSBundle.mainBundle().pathForResource("level\(level)", ofType: "txt") {
            if let levelContents = try? String(contentsOfFile: levelFilePath, usedEncoding: nil) {
                
                var lines = levelContents.componentsSeparatedByString("\n")
                lines = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(lines) as! [String]
                
                for (index,line) in lines.enumerate() {
                    let parts = line.componentsSeparatedByString(": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    clueString += "\(index + 1). \(clue) \n"
                    
                    let solutionWord = answer.stringByReplacingOccurrencesOfString("|", withString: "")
                    
                    solutionString += "\(solutionWord.characters.count) letters \n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.componentsSeparatedByString("|")
                    letterBits += bits
                }
                
            }
        }
        cluesLabel.text = clueString.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
        answersLabel.text = solutionString.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
        
        letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(letterBits) as! [String]
        letterButtons = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(letterButtons) as! [UIButton]
        
        if letterBits.count == letterButtons.count {
            for i in 0 ..< letterBits.count {
                letterButtons[i].setTitle(letterBits[i], forState: .Normal)
            }
        }
        
    }
    
    func letterTapped(btn: UIButton) {
        currentAnswer.text = currentAnswer.text! + btn.titleLabel!.text!
        activatedButtons.append(btn)
        btn.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

