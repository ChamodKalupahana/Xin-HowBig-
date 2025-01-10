//
//  ARController.swift
//  How Big?
//
//  Created by User on 27/12/2024.
//

import SwiftUI
import ARKit

struct ARController: View {
    var arViewContainer = ARViewContainer()
    @StateObject var coordinator = Coordinator.shared
    var body: some View {
        ZStack(alignment: .topTrailing){
            arViewContainer
            resetButton
        }
    }
    
    var resetButton : some View {
        Button {
            coordinator.resetPoints()
        } label: {
            Text("Reset")
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 7.5))
                .padding()
        }

    }
}


struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        
        // Configure ARSession
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        arView.session.run(configuration)
        
        arView.delegate = context.coordinator
        arView.scene = SCNScene() // init with empty scene
        
        // add gesture for tap
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        arView.addGestureRecognizer(tapGesture)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        // No updates needed for now
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator.shared
    }
}


#Preview {
    ARController()
}
