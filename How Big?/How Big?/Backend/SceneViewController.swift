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
        
        // Load Object
        if let objectNode = SCNScene(named: "art.scnassets/Cottage_FREE")?.rootNode.clone() {
            scene.rootNode.addChildNode(objectNode)
            rotate(node: objectNode)
            
        }
        
        // add XYZ axes
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
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
        xAxis.firstMaterial?.diffuse.contents = Color.red
        let xNode = SCNNode(geometry: xAxis)
        xNode.eulerAngles = SCNVector3(0, 0, Float.pi / 2)
        xNode.position = SCNVector3(length / 2, 0, 0)
        
        let yAxis = SCNCylinder(radius: thickness, height: length)
        yAxis.firstMaterial?.diffuse.contents = Color.green
        let yNode = SCNNode(geometry: yAxis)
        yNode.position = SCNVector3(length / 2, 0, 0)
        
        let zAxis = SCNCylinder(radius: thickness, height: length)
        zAxis.firstMaterial?.diffuse.contents = Color.blue
        let zNode = SCNNode(geometry: zAxis)
        zNode.eulerAngles = SCNVector3(Float.pi / 2, 0, 0)
        zNode.position = SCNVector3(0, 0, length / 2)
        
        rootNode.addChildNode(xNode)
        rootNode.addChildNode(yNode)
        rootNode.addChildNode(zNode)
        
    }
}


