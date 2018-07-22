//
//  GameViewController.swift
//  ColorSwitch
//
//  Created by Kevin Amiranoff on 21/07/2018.
//  Copyright © 2018 Nemean Tale Studios. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = MenuScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            
            view.presentScene(scene)

            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
}
