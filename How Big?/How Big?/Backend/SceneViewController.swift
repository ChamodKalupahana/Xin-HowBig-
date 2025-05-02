//
//  SceneViewController.swift
//  How Big?
//
//  Created by User on 03/05/2025.
//

import Foundation
import SwiftUI
import SceneKit

struct SceneViewController : UIViewRepresentable {
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        
        // Create Scene
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        
        // Load Object
        if let objectNode = SCNScene(named: "art.scnassets/Cottage_FREE")?.rootNode.clone() {
            scene.rootNode.addChildNode(objectNode)
            // rotate
            
        }
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
    }
    
    func rotate(node : SCNNode) {
        let spin = CABasicAnimation(keyPath: "rotation")
        spin.fromValue = SCNVector4(0, 1, 0, 0)
        spin.toValue = SCNVector4(0, 1, 0, Float.pi * 2)
        spin.duration = 10
        spin.repeatCount = .infinity
        node.addAnimation(spin, forKey: "spin")
    }
}


