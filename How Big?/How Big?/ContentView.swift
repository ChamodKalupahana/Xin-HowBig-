//
//  ContentView.swift
//  How Big?
//
//  Created by User on 02/05/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            Compare()
                .tabItem {
                    Image(systemName: "scale.3d")
                    Text("Compare")
                        .font(.customBody)
                }
        }
    }
}

#Preview {
    ContentView()
}
