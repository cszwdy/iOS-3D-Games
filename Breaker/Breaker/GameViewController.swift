//
//  GameViewController.swift
//  Breaker
//
//  Created by Emiaostein on 7/18/16.
//  Copyright © 2016 Emiaostein. All rights reserved.
//

import UIKit
import SceneKit
import GameplayKit

class GameViewController: UIViewController {
    
    var scnView:SCNView!
    var scnScene: SCNScene!
    weak var game: GameHelper! = GameHelper.sharedInstance
    weak var horCamera: SCNNode!
    weak var verCamera: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1 
        setupScene()
        setupNodes()
        setupSounds()
        
    }
    
    // 2 
    func setupScene() {
        scnView = self.view as! SCNView
        scnView.delegate = self
        
        scnScene = SCNScene(named: "Breaker.scnassets/Scenes/Game.scn")
        scnView.scene = scnScene
        scnScene.rootNode.addChildNode(game.hudNode)
        
    }
    
    func setupNodes() {
        horCamera = scnScene.rootNode.childNode(withName: "HorCamera", recursively: true)
        verCamera = scnScene.rootNode.childNode(withName: "VerCamera", recursively: true)
    }
    
    func setupSounds() {
    
    }
    
    override func shouldAutorotate() -> Bool {
        
        return true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let orientation = UIDevice.current().orientation
        switch orientation {
        case .portrait:
            scnView.pointOfView = verCamera
        default:
            scnView.pointOfView = horCamera
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
        
    }
    
}

// 3
extension GameViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        game.updateHUD()
    }
}
