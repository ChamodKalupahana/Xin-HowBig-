//
//  Compare.swift
//  How Big?
//
//  Created by User on 02/05/2025.
//

import SwiftUI

struct Compare: View {
    var body: some View {
        ZStack(alignment: .topLeading){
            SceneViewController()
                .ignoresSafeArea()
            
            Text("How Big?")
                .font(.title)
                .fontWeight(.bold)
                .padding()
        }
        .background(Color(.background))
    }
}

#Preview {
    Compare()
}
