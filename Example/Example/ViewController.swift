//
//  ViewController.swift
//  Example
//
//  Created by Matthias Fey on 10.08.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = self.view as! SKView
        let scene = Scene(size: view.bounds.size)
        
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
