//
//  ObjectInteractionCoordinatorDragToPanOrbitToRotate.swift
//  How Big?
//
//  Created by User on 16/05/2025.
//

import Foundation
import SceneKit

class ObjectInteractionCoordinatorDragToPanOrbitToRotate : NSObject, InteractionCoordinator {

    var initalisedCameraControlMethod: CameraControlMethod
    
    var sceneView: SCNView?
    var currentNode: SCNNode?
    
    var plantNode: SCNNode?
    var cameraNode: SCNNode?
    
    var focusTargetNode: SCNNode?
    var cottageNode: SCNNode?
    
    
    init(initalisedCameraControlMethod: CameraControlMethod, sceneView: SCNView? = nil, currentNode: SCNNode? = nil, plantNode: SCNNode? = nil, cameraNode: SCNNode? = nil, focusTargetNode: SCNNode? = nil, cottageNode: SCNNode? = nil) {
        self.initalisedCameraControlMethod = initalisedCameraControlMethod
        self.sceneView = sceneView
        self.currentNode = currentNode
        self.plantNode = plantNode
        self.cameraNode = cameraNode
        self.focusTargetNode = focusTargetNode
        self.cottageNode = cottageNode
    }
    
    func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let cameraNode = cameraNode else { return }
        return
    }
    
    func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let cameraNode = cameraNode else { return }
        
        let translation = gesture.translation(in: gesture.view)
        let panSensitivity : Float = 0.05
        
        let deltaX = Float(translation.x) * panSensitivity
        let deltaY = Float(translation.y) * panSensitivity
        
        cameraNode.position.x -= deltaX
        cameraNode.position.y += deltaY
        
        gesture.setTranslation(.zero, in: gesture.view)
        return
    }
    
    func handleRotation(_ gesture: UIRotationGestureRecognizer) {
        return
    }
    
    // not used for dragToPanOrbitToRotate
    func handleTap(_ gesture: UITapGestureRecognizer) {
        return
    }
    
    func focusOnNode(on node: SCNNode) {
        return
    }
    
    
}
