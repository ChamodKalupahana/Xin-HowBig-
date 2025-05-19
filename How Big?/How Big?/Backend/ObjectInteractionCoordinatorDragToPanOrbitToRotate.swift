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
        
        let scalingInZAxis = false
        
        let scale = Float(gesture.scale)
        
        if (scalingInZAxis) {
            let newZ = cameraNode.position.z / scale
            
            cameraNode.position.z = max(-50, min(50, newZ))
        } else {
            let zoomSensitivity : Float = 50
            
            // calculate the zoom vector (camera's forward direction)
            let cameraDirection = cameraNode.worldFront
            let factor = (1 - scale)
            let zoomVector = SCNVector3(cameraDirection.x * zoomSensitivity * factor,
                                        cameraDirection.y * zoomSensitivity * factor,
                                        cameraDirection.z * zoomSensitivity * factor)
            
            // Update the camera position in it's look direction
            cameraNode.position = cameraNode.position - zoomVector
            
            // Limit the zoom range
            let maxDistance : Float = 100
            let minDistance : Float = 1
            
            let distanceFromOrigin = sqrt(pow(cameraNode.position.x, 2) +
                                          pow(cameraNode.position.y, 2) +
                                          pow(cameraNode.position.z, 2))
            
            if distanceFromOrigin > maxDistance {
                cameraNode.position = cameraNode.position.normalized() * maxDistance
            } else if distanceFromOrigin < minDistance {
                cameraNode.position = cameraNode.position.normalized() * minDistance
            }
        }
        
        gesture.scale = 1.0
        updateCenterOfRotation()
        return
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let cameraNode = cameraNode else { return }
        
        let translateAroundCenterOfRotation = true
        
        let translation = gesture.translation(in: gesture.view)
        let panSensitivity : Float = 0.05
        
        let deltaX = Float(translation.x) * panSensitivity
        let deltaY = Float(translation.y) * panSensitivity
        
        if (translateAroundCenterOfRotation) {
            let localTransform = SCNVector3(-deltaX, deltaY, 0)
            let worldTransform = cameraNode.convertPosition(localTransform, to: nil)
            cameraNode.position = worldTransform
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
        let translationToFocus = SCNMatrix4MakeTranslation(-centerOfRotation.x, -centerOfRotation.y, -centerOfRotation.z)
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

extension SCNVector3 {
    static func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3(left.x + right.x, left.y + right.y, left.z + right.z)
    }
    
    static func - (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3(left.x - right.x, left.y - right.y, left.z - right.z)
    }

    static func * (vector: SCNVector3, scalar: Float) -> SCNVector3 {
        return SCNVector3(vector.x * scalar, vector.y * scalar, vector.z * scalar)
    }
    
    func normalized() -> SCNVector3 {
        let length = sqrt(x * x + y * y + z * z)
        return length == 0 ? self : SCNVector3(x / length, y / length, z / length)
    }
}
