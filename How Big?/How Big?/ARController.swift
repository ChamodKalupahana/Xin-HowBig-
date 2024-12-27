//
//  ARController.swift
//  How Big?
//
//  Created by User on 27/12/2024.
//

import SwiftUI
import ARKit

struct ARViewController : UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        let arView = ARSCNView()
        
        // Config ARSession
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        arView.session.run(configuration)
        
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        return
    }
    
}

struct ARController: View {
    var body: some View {
        ARViewController()
            .ignoresSafeArea(.all)
    }
}

#Preview {
    ARController()
}
