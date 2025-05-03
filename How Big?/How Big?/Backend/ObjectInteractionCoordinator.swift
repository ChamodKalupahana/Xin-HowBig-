//
//  ObjectInteractionCoordinator.swift
//  How Big?
//
//  Created by User on 03/05/2025.
//

import SwiftUI
import SceneKit

class ObjectInteractionCoordinator : NSObject {
    var sceneView : SCNView?
    var currentNode : SCNNode?
    
    @objc func handlePan(_ gesture : UIPanGestureRecognizer) {
        guard let sceneView = sceneView else { return }
        
        let location = gesture.location(in: sceneView)
        
        switch gesture.state {
        case .began:
            let hitResults = sceneView.hitTest(location, options: nil)
            if let hit = hitResults.first {
                currentNode = hit.node
            }
            
        case .changed:
            guard let node = currentNode else { return }
            
            let translation = gesture.translation(in: sceneView)
            let deltaX = Float(translation.x) * 0.01
            let deltaY = Float(translation.y) * 0.01
        }
    }
}
