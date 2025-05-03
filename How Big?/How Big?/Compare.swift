//
//  Compare.swift
//  How Big?
//
//  Created by User on 02/05/2025.
//

import SwiftUI

struct Compare: View {
    var body: some View {
        ZStack{
            SceneViewController()
                .ignoresSafeArea()
            
            VStack{
                Text("How Big?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("This is house is 20m long, same as your idol")
                    .font(.headline)
            }
            .padding()
        }
        .background(Color(.background))
    }
}

#Preview {
    Compare()
}
