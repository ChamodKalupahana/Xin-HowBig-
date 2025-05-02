//
//  RealityViewController.swift
//  How Big?
//
//  Created by User on 27/12/2024.
//

import SwiftUI
import RealityKit

struct RealityViewController: View {
    var body: some View {
        ZStack{
            if #available(iOS 18.0, *) {
                RealityView { content in
                    
                    // Create a cube model
                    let model = Entity()
                    let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
                    let material = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true)
                    model.components.set(ModelComponent(mesh: mesh, materials: [material]))
                    model.position = [0, 0.05, 0]
                    
                    // Create horizontal plane anchor for the content
                    let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
                    anchor.addChild(model)
                    
                    // Add the horizontal plane anchor to the scene
                    content.add(anchor)
                    
                    content.camera = .spatialTracking
                    
                }
                .edgesIgnoringSafeArea(.all)
            } else {
                Text("Upgrade to iOS 18")
            }
        }
        

    }
}

#Preview {
    RealityViewController()
}

