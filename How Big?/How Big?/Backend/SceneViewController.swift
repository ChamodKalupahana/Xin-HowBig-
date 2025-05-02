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
        
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
    }
}


