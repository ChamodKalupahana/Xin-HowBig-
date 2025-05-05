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
        sceneView.backgroundColor = UIColor(resource: .background)
        
        let containerNode = SCNNode()
        scene.rootNode.addChildNode(containerNode)
        
        let centerNode = SCNNode()
        scene.rootNode.addChildNode(centerNode)
        
        // Load Object
        guard let objectNode = SCNScene(named: "art.scnassets/Cottage_FREE.scn")?.rootNode.clone() else {
            print("Cottage_FREE not found")
            return sceneView // return early to show erorr
        }
        
        containerNode.addChildNode(objectNode)
        
        guard let footballNode = SCNScene(named: "art.scnassets/Football.scn")?.rootNode.clone() else {
            print("footballNode not found")
            return sceneView // return early to show erorr
        }
        
        footballNode.position = SCNVector3(10, 0, 0)
        containerNode.addChildNode(footballNode)
        context.coordinator.currentNode = containerNode
        
        // add XYZ axes
        addXYZAxes(to: containerNode, basedOn: objectNode)
    
        
        
        // add in panning
        context.coordinator.sceneView = sceneView
        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(ObjectInteractionCoordinator.handlePan(_:)))
        sceneView.addGestureRecognizer(panGesture)
        context.coordinator.currentNode = containerNode
        
        // add in camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        let distance : Float = 50
        let angle45 = Float.pi / 4
        let x = distance * sin(angle45)
        let z = distance * cos(angle45)
        
        cameraNode.position = SCNVector3(x: x, y: 20, z: z)
        cameraNode.look(at: containerNode.position)
        scene.rootNode.addChildNode(cameraNode)
        
        // add in scaling
        let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(ObjectInteractionCoordinator.handlePinch(_:)))
        sceneView.addGestureRecognizer(pinchGesture)

        
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
    }
    
    func makeCoordinator() -> ObjectInteractionCoordinator {
        ObjectInteractionCoordinator()
    }
    
    func rotate(node : SCNNode) {
        let spin = CABasicAnimation(keyPath: "rotation")
        spin.fromValue = SCNVector4(0, 1, 0, 0)
        spin.toValue = SCNVector4(0, 1, 0, Float.pi * 2)
        spin.duration = 10
        spin.repeatCount = .infinity
        node.addAnimation(spin, forKey: "spin")
    }
    
    func addXYZAxes(to rootNode : SCNNode, basedOn objectNode : SCNNode) {
        let length : CGFloat = 25.0
        let thickness : CGFloat = 0.25
        
        let xAxis = SCNCylinder(radius: thickness, height: length)
        xAxis.firstMaterial?.diffuse.contents = UIColor.red
        let xNode = SCNNode(geometry: xAxis)
        xNode.eulerAngles = SCNVector3(0, 0, Float.pi / 2)
        xNode.position = SCNVector3(length / 2, 0, 0)
        
        let yAxis = SCNCylinder(radius: thickness, height: length)
        yAxis.firstMaterial?.diffuse.contents = UIColor.green
        let yNode = SCNNode(geometry: yAxis)
        yNode.position = SCNVector3(0, length / 2, 0)
        
        let zAxis = SCNCylinder(radius: thickness, height: length)
        zAxis.firstMaterial?.diffuse.contents = UIColor.blue
        let zNode = SCNNode(geometry: zAxis)
        zNode.eulerAngles = SCNVector3(Float.pi / 2, 0, 0)
        zNode.position = SCNVector3(0, 0, length / 2)
        
        let axesContainer = SCNNode()
        axesContainer.addChildNode(xNode)
        axesContainer.addChildNode(yNode)
        axesContainer.addChildNode(zNode)
        
        // Position axesContainer at the front-left-bottom corner of objectNode
        var min = SCNVector3Zero
        var max = SCNVector3Zero
        objectNode.__getBoundingBoxMin(&min, max: &max)
        axesContainer.position = SCNVector3(min.x, min.y, min.z)
        
        
        // add to root
        rootNode.addChildNode(axesContainer)
        
        
    }
}


