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
    
    @objc func handlePan(_ gesture : UIPanGestureRecognizer) {
        guard let sceneView = sceneView else { return }
        
        let location = gesture.location(in: sceneView)
        
        switch gesture.state {
        case .possible:
            <#code#>
        case .began:
            <#code#>
        case .changed:
            <#code#>
        case .ended:
            <#code#>
        case .cancelled:
            <#code#>
        case .failed:
            <#code#>
        case .recognized:
            <#code#>
        }
    }
}
