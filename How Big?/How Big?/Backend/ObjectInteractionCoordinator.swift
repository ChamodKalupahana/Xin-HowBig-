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
        
        _ = gesture.location(in: sceneView)
        let translation = gesture.translation(in: sceneView)
        
        switch gesture.state {
        case .began:
            // Don't reassign currentNode on touch
//            let hitResults = sceneView.hitTest(location, options: nil)
//            if let hit = hitResults.first {
//                currentNode = hit.node
//            }
            break
            
        case .changed:
            guard let node = currentNode else { return }
            
            let deltaX = Float(translation.x) * 0.01
            let deltaY = Float(translation.y) * 0.01
            
            // for panning
//            node.position.x += deltaX
//            node.position.y -= deltaY
            
            let yRotation = SCNMatrix4MakeRotation(-deltaX, 0, 1, 0)
            let xRotation = SCNMatrix4MakeRotation(-deltaY, 1, 0, 0)
            let rotation = SCNMatrix4Mult(xRotation, yRotation)
            
            node.transform = SCNMatrix4Mult(rotation, node.transform)
            
            gesture.setTranslation(.zero, in: sceneView)
            
        case .ended, .cancelled:
//            currentNode = nil
            break
        
        default:
            break
        }
    }
}
