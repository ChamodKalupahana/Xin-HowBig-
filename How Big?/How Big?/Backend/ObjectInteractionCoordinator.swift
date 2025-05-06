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
    
    var plantNode : SCNNode?
    var cameraNode : SCNNode?
    
    var focusTargetNode : SCNNode?
    
    @objc func handlePan(_ gesture : UIPanGestureRecognizer) {
        guard let sceneView = sceneView else { return }
        
        _ = gesture.location(in: sceneView)
        let translation = gesture.translation(in: sceneView)
        
        switch gesture.state {
        case .began:
            // Don't reassign currentNode on touch
//            let hitResults = sceneView.hitTest(location, options: nil)
//            if let hit = hitResults.first {
//                currentNode = hit.node //
//            }
            break
            
        case .changed:
            guard let node = currentNode else { return }
            
            let deltaX = Float(translation.x) * 0.01
            _ = Float(translation.y) * 0.01
            
            // for panning
//            node.position.x += deltaX
//            node.position.y -= deltaY
            
            let yRotation = SCNMatrix4MakeRotation(-deltaX, 0, 1, 0)
//            let xRotation = SCNMatrix4MakeRotation(-deltaY, 1, 0, 0)
//            let rotation = SCNMatrix4Mult(xRotation, yRotation)
            
            node.transform = SCNMatrix4Mult(yRotation, node.transform)
            
            gesture.setTranslation(.zero, in: sceneView)
            
        case .ended, .cancelled:
//            currentNode = nil
            break
        
        default:
            break
        }
    }
    
    @objc func handlePinch(_ gesture : UIPinchGestureRecognizer) {
        guard let node = currentNode else { return }
        
        switch gesture.state {
        case .changed:
            let scale = Float(gesture.scale)
            let newScale = SCNVector3(
                node.scale.x * scale,
                node.scale.y * scale,
                node.scale.z * scale
            )
            
            let minScale : Float = 0.1
            let maxScale : Float = 10.0
            node.scale = SCNVector3(
                max(minScale, min(maxScale, newScale.x)),
                max(minScale, min(maxScale, newScale.y)),
                max(minScale, min(maxScale, newScale.z))
            )
            
            gesture.scale = 1.0
        default:
            break
        }
    }
    
    func focusOnPlant() {
        guard let plantNode = plantNode, let cameraNode = cameraNode else { return }
        
//        currentNode = plantNode
        
        // move camera to orbut around the plant
        let distance : Float = 20
        let angle45 : Float = Float.pi / 4
        let x = plantNode.position.x + distance * sin(angle45)
        let z = plantNode.position.z + distance * cos(angle45)
        let y = plantNode.position.y + 10
        
        let newPosition = SCNVector3(x, y, z)
        
        let moveAction = SCNAction.move(to: newPosition, duration: 0.5)
        moveAction.timingMode = .easeInEaseOut
        cameraNode.runAction(moveAction) {
            cameraNode.look(at: plantNode.position)
        }
        
//        cameraNode.look(at: plantNode.position)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let sceneView = sceneView, let plantNode = plantNode else { return }
        
        let location = gesture.location(in: sceneView)
        let hitResults = sceneView.hitTest(location, options: nil)
        
        for result in hitResults {
            if result.node == plantNode || plantNode.childNodes.contains(result.node) {
                focusOnPlant()
                break
            }
        }
    }
    
    func focusOnNode(on node: SCNNode) {
        guard let cameraNode = cameraNode else { return }
        
        focusTargetNode = node
        
        // move camera to orbit around the input node
        let distance : Float = 20
        let angle45 : Float = Float.pi / 4
        let x = node.position.x + distance * sin(angle45)
        let z = node.position.z + distance * cos(angle45)
        let y = node.position.y + 10
        
        let newPosition = SCNVector3(x, y, z)
        
    }
}
