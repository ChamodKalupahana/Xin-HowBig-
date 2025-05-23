//
//  ContentView.swift
//  How Big?
//
//  Created by User on 27/12/2024.
//

import SwiftUI

struct ContentViewOld : View {
    var body: some View {
        TabView {
            
            Compare()
                .tabItem {
                    Image(systemName: "scale.3d")
                    Text("Compare")
                }
            
            Measure()
                .tabItem {
                    Image(systemName: "camera.fill")
                    Text("Measure")
                }
            
            ManualInput()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Manual Input")
                }
            
            Profile()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("You")
                }
            
            Share()
                .tabItem {
                    Image(systemName: "paperplane.fill")
                    Text("Share")
                }

        }
    }

}




#Preview {
    ContentViewOld()
}
