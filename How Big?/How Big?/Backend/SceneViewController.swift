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
    let cottageObjectPath = "art.scnassets/Cottage_FREE.scn"
    let plantObjectPath = "art.scnassets/indoor plant_02.scn"
//    let plantObjectPath = "art.scnassets/Football.scn"
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        
        // Create Scene
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = UIColor(resource: .background)
        
        let containerNode = SCNNode()
        scene.rootNode.addChildNode(containerNode)
        
        // Load Object
        guard let cottageNode = SCNScene(named: cottageObjectPath)?.rootNode.clone() else {
            print("Cottage_FREE not found")
            return sceneView // return early to show erorr
        }
        
        containerNode.addChildNode(cottageNode)
        context.coordinator.cottageNode = cottageNode
        
        guard let plantNode = SCNScene(named: plantObjectPath)?.rootNode.clone() else {
            print("plantNode not found")
            return sceneView // return early to show erorr
        }
//        print("plantNode children count: \(plantNode.childNodes.count)")
        
        plantNode.position = SCNVector3(12, 0, 0)
        containerNode.addChildNode(plantNode)
        context.coordinator.currentNode = containerNode
        context.coordinator.plantNode = plantNode
        
        // add XYZ axes
        addXYZAxes(to: containerNode, basedOn: cottageNode)
    
        
        
        // add in panning
        context.coordinator.sceneView = sceneView
        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(ObjectInteractionCoordinator.handlePan(_:)))
        sceneView.addGestureRecognizer(panGesture)
        
        // add in camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        let distance : Float = 50
        let angle45 = Float.pi / 4
        let x = distance * sin(angle45)
        let z = distance * cos(angle45)
        
        cameraNode.position = SCNVector3(x: x, y: 20, z: z)
//        cameraNode.look(at: containerNode.position)
        scene.rootNode.addChildNode(cameraNode)
        
        context.coordinator.cameraNode = cameraNode
        context.coordinator.focusOnNode(on: cottageNode)
        
        // add in scaling
        let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(ObjectInteractionCoordinator.handlePinch(_:)))
        sceneView.addGestureRecognizer(pinchGesture)
        
        // add in lighting
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .directional
        lightNode.light?.color = UIColor.white

        // Rotate the light downward and forward at an angle
        lightNode.eulerAngles = SCNVector3(-Float.pi / 3, -Float.pi / 4, 0)

        scene.rootNode.addChildNode(lightNode)
        
        // add in tap gesture
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(ObjectInteractionCoordinator.handleTap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
        
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
    
    func addXYZAxes(to containerNode : SCNNode, basedOn objectNode : SCNNode) {
        let length : CGFloat = 250.0
        let thickness : CGFloat = 0.15
        let step : CGFloat = 5.0 // distnace between scale marks
        
        let font = UIFont.systemFont(ofSize: 10)
        
        func makeLabel(_ text : String) -> SCNNode {
            let textGeometry = SCNText(string : text, extrusionDepth: 0.5)
            textGeometry.font = font
            textGeometry.flatness = 0.1
            textGeometry.firstMaterial?.diffuse.contents = UIColor.white
            
            let node = SCNNode(geometry: textGeometry)
            let (min, max) = textGeometry.boundingBox
            let width = max.x - min.x
            node.pivot = SCNMatrix4MakeTranslation(width / 2, min.y, 0) // center the text
            node.scale = SCNVector3(0.2, 0.2, 0.2)
            return node
        }
        
        func addScaleMarks(to parent: SCNNode, direction : SCNVector3, axis : Dimension) {
            for i in 0...Int(length / step) {
                let pos = Float(step) * Float(i)
                let labelNode =  makeLabel("\(i * Int(step)) m")
                labelNode.position = SCNVector3(
                    axis == .x ? pos : 0,
                    axis == .y ? pos : 0,
                    axis == .z ? pos : 0
                )
                
//                labelNode.eulerAngles = axis == .x ? SCNVector3(0, 0, -Float.pi / 2) :
//                axis == .z ? SCNVector3(-Float.pi / 2, 0, 0) :
//                                    SCNVector3Zero
                if (axis == .x) {
                    labelNode.eulerAngles = SCNVector3(0, Float.pi / 2, 0)
                }
                parent.addChildNode(labelNode)
            }
        }
        
        let xAxis = SCNCylinder(radius: thickness, height: length)
        xAxis.firstMaterial?.diffuse.contents = UIColor.black
        let xNode = SCNNode(geometry: xAxis)
        xNode.eulerAngles = SCNVector3(0, 0, Float.pi / 2)
        xNode.position = SCNVector3(length / 2, 0, 0)
        
        let yAxis = SCNCylinder(radius: thickness, height: length)
        yAxis.firstMaterial?.diffuse.contents = UIColor.black
        let yNode = SCNNode(geometry: yAxis)
        yNode.position = SCNVector3(0, length / 2, 0)
        
        let zAxis = SCNCylinder(radius: thickness, height: length)
        zAxis.firstMaterial?.diffuse.contents = UIColor.black
        let zNode = SCNNode(geometry: zAxis)
        zNode.eulerAngles = SCNVector3(Float.pi / 2, 0, 0)
        zNode.position = SCNVector3(0, 0, length / 2)
        
        let axesContainer = SCNNode()
        axesContainer.addChildNode(xNode)
        axesContainer.addChildNode(yNode)
        axesContainer.addChildNode(zNode)
        
        addScaleMarks(to: axesContainer, direction: SCNVector3(1,0,0), axis: .x)
        addScaleMarks(to: axesContainer, direction: SCNVector3(0,1,0), axis: .y)
        addScaleMarks(to: axesContainer, direction: SCNVector3(0,0,1), axis: .z)
        
        // Position axesContainer at the front-left-bottom corner of objectNode
        var min = SCNVector3Zero
        var max = SCNVector3Zero
        objectNode.__getBoundingBoxMin(&min, max: &max)
        axesContainer.position = SCNVector3(min.x, min.y, min.z)
        
        
        // add to root
        containerNode.addChildNode(axesContainer)
    }
}


