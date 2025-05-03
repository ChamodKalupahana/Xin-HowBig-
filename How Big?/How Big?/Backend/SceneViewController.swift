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
        
        let containerNode = SCNNode()
        scene.rootNode.addChildNode(containerNode)
        
        // Load Object
        if let objectNode = SCNScene(named: "art.scnassets/Cottage_FREE.dae")?.rootNode.clone() {
            containerNode.addChildNode(objectNode)
            // for automatic rotation
//            rotate(node: objectNode)
            context.coordinator.currentNode = containerNode
            
        } //
        
        // add XYZ axes yay
        addXYZAxes(to: containerNode)
        
        // add in panning
        context.coordinator.sceneView = sceneView
        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(ObjectInteractionCoordinator.handlePan(_:)))
        sceneView.addGestureRecognizer(panGesture)
        context.coordinator.currentNode = containerNode
        
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
    
    func addXYZAxes(to rootNode : SCNNode) {
        let length : CGFloat = 5.0
        let thickness : CGFloat = 0.05
        
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
        
        rootNode.addChildNode(xNode)
        rootNode.addChildNode(yNode)
        rootNode.addChildNode(zNode)
        
    }
}


