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
    
    var distanceToObjects : Float = 50.0
    var centerOfRotation : SCNVector3 = SCNVector3Zero
    
    
    init(initalisedCameraControlMethod: CameraControlMethod, sceneView: SCNView? = nil, currentNode: SCNNode? = nil, plantNode: SCNNode? = nil, cameraNode: SCNNode? = nil, focusTargetNode: SCNNode? = nil, cottageNode: SCNNode? = nil) {
        self.initalisedCameraControlMethod = initalisedCameraControlMethod
        self.sceneView = sceneView
        self.currentNode = currentNode
        self.plantNode = plantNode
        self.cameraNode = cameraNode
        self.focusTargetNode = focusTargetNode
        self.cottageNode = cottageNode
    }
    
    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let cameraNode = cameraNode else { return }
        
        let scale = Float(gesture.scale)
        let newZ = cameraNode.position.z / scale
        
        cameraNode.position.z = max(-50, min(50, newZ))
        gesture.scale = 1.0
        
        updateCenterOfRotation()
        return
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let cameraNode = cameraNode else { return }
        
        let translateAroundCenterOfRotation = false
        
        let translation = gesture.translation(in: gesture.view)
        let panSensitivity : Float = 0.05
        
        let deltaX = Float(translation.x) * panSensitivity
        let deltaY = Float(translation.y) * panSensitivity
        
        if (translateAroundCenterOfRotation) {
            let translationMatrix = SCNMatrix4MakeTranslation(deltaX, -deltaY, 0)
            let toCenter = SCNMatrix4MakeTranslation(-centerOfRotation.x, -centerOfRotation.y, -centerOfRotation.z)
            let backToPosition = SCNMatrix4MakeTranslation(centerOfRotation.x, centerOfRotation.y, centerOfRotation.z)
            
            let panTransform = SCNMatrix4Mult(SCNMatrix4Mult(toCenter, translationMatrix), backToPosition)
            
            cameraNode.transform = SCNMatrix4Mult(cameraNode.transform, panTransform)
            
        } else {
            cameraNode.position.x -= deltaX
            cameraNode.position.y += deltaY
        }
        
        gesture.setTranslation(.zero, in: gesture.view)
        
        updateCenterOfRotation()
        return
    }
    
    @objc func handleOrbit(_ gesture: UIRotationGestureRecognizer) {
        guard let cameraNode = cameraNode else { return }
        
        let rotation = Float(gesture.rotation)
        
        let orbitSensitivity : Float = 0.5
        let rotationDelta = rotation * orbitSensitivity
        
        // Create a transform that represents rotation around the rotation center
        let translationToFocus = SCNMatrix4MakeTranslation(-centerOfRotation.x, -centerOfRotation.y, centerOfRotation.z)
        let translationBack = SCNMatrix4MakeTranslation(centerOfRotation.x, centerOfRotation.y, centerOfRotation.z)
        
        let rotationMatrix = SCNMatrix4MakeRotation(rotationDelta, 0, 1, 0)
        let transform = SCNMatrix4Mult(SCNMatrix4Mult(translationToFocus, rotationMatrix), translationBack)
        
        cameraNode.transform = SCNMatrix4Mult(cameraNode.transform, transform)
        
        gesture.rotation = 0
        return
    }
    
    // not used for dragToPanOrbitToRotate
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        return
    }
    
    func focusOnNode(on node: SCNNode) {
        return
    }
    
    func updateCenterOfRotation() {
        guard let cameraNode else { return }
        
        let cameraPosition = cameraNode.position
        
        let forwardVector = SCNVector3(0, 0, -distanceToObjects)
        let worldForwardVector = cameraNode.convertPosition(forwardVector, to: nil)
        
        centerOfRotation = worldForwardVector
        
    }
    
    
}
