//
//  Coordinator.swift
//  How Big?
//
//  Created by User on 27/12/2024.
//

import Foundation
import ARKit

class Coordinator : NSObject, ARSCNViewDelegate, ObservableObject {
    
    static let shared = Coordinator()
    
    private var startPoint : SCNNode?
    private var endPoint : SCNNode?
    @Published private(set) var distanceTextNode : SCNNode?
    @Published private(set) var selectedDistance : Float?
    
    
    @objc func handleTap(_ sender : UITapGestureRecognizer) {
        guard let view = sender.view as? ARSCNView else {
            return
        }
        
        let location = sender.location(in: view)
        let results = view.hitTest(location, types: [.featurePoint, .existingPlaneUsingExtent])
        
        guard let hitResult = results.first else {
            return
        }
        
        let position = SCNVector3(x: hitResult.worldTransform.columns.3.x,y: hitResult.worldTransform.columns.3.y, z: hitResult.worldTransform.columns.3.z)
        
        if startPoint == nil {
            // create and place start point
            startPoint = createSphere(at: position, color: .green)
            view.scene.rootNode.addChildNode(startPoint!)
        } else if endPoint == nil {
            endPoint = createSphere(at: position, color: .red)
            view.scene.rootNode.addChildNode(endPoint!)
            
            // measure the distance
            if let start = startPoint, let end = endPoint {
                let distance = calculateDistance(from: start.position, to: end.position)
                displayDistance(distance, at: end.position, in: view)
            }
        } else {
            // reset points
            resetPoints()
        }
    }
    
    
    
    private func createSphere(at position : SCNVector3, color : UIColor) -> SCNNode {
        let sphere = SCNSphere(radius: 0.005)
        sphere.firstMaterial?.diffuse.contents = color
        let node = SCNNode(geometry: sphere)
        node.position = position
        return node
    }
    
    private func calculateDistance(from start : SCNVector3, to end: SCNVector3) -> Float {
        let dx = end.x - start.x
        let dy = end.y - start.y
        let dz = end.z - start.z
        return sqrt(dx * dx + dy * dy + dz * dz)
    }
    
    private func displayDistance(_ distance : Float, at position : SCNVector3, in view : ARSCNView) {
        
        // Remove the previous distance text node if it exists
        distanceTextNode?.removeFromParentNode()
        
        selectedDistance = distance
        
        let SCNTextString = self.formatDistance(distance: distance)
        let text = SCNText(string: SCNTextString, extrusionDepth: 0.1)
        text.firstMaterial?.diffuse.contents = UIColor.yellow
        let textNode = SCNNode(geometry: text)
        textNode.scale = SCNVector3(0.01, 0.01, 0.01)
        textNode.position = position
        
        
        
        view.scene.rootNode.addChildNode(textNode)
        distanceTextNode = textNode
        
    }
    
    func resetPoints() {
        // reset points
        startPoint?.removeFromParentNode()
        endPoint?.removeFromParentNode()
        distanceTextNode?.removeFromParentNode()
        startPoint = nil
        endPoint = nil
        distanceTextNode = nil
        selectedDistance = nil
    }
    
    func formatDistance(distance : Float) -> String {
        return String(format: "%.2f meters", distance)
    }
    
}
