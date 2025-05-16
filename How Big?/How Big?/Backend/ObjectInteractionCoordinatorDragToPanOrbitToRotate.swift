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
    
    var rotationCenter: SCNVector3 = SCNVector3Zero
    
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
        
        // Update the rotation center after zoom
        updateRotationCenter()
        return
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let cameraNode = cameraNode else { return }
        
        let translation = gesture.translation(in: gesture.view)
        let panSensitivity : Float = 0.05
        
        let deltaX = Float(translation.x) * panSensitivity
        let deltaY = Float(translation.y) * panSensitivity
        
        cameraNode.position.x -= deltaX
        cameraNode.position.y += deltaY
        
        gesture.setTranslation(.zero, in: gesture.view)
        
        // Initialize the rotation center
        updateRotationCenter()
        return
    }
    
    @objc func handleOrbit(_ gesture: UIRotationGestureRecognizer) {
        guard let cameraNode = cameraNode else { return }
        
        let rotation = Float(gesture.rotation)
        
        let orbitSensitivity: Float = 0.5
        let rotationDelta = rotation * orbitSensitivity
        
        // Create a transform that represents rotation around the rotation center
        let translationToFocus = SCNMatrix4MakeTranslation(-rotationCenter.x, -rotationCenter.y, -rotationCenter.z)
        let translationBack = SCNMatrix4MakeTranslation(rotationCenter.x, rotationCenter.y, rotationCenter.z)
        
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
    
    func updateRotationCenter() {
        guard let cameraNode = cameraNode else { return }
        // Calculate the point 50 units in front of the camera
        let cameraPosition = cameraNode.position
        
        // Transform the forward direction by 50 units
        let forwardVector = SCNVector3(0, 0, -50)
        let worldForwardVector = cameraNode.convertPosition(forwardVector, to: nil)
        
        rotationCenter = worldForwardVector
    }
    
    
}
