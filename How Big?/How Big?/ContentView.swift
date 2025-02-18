//
//  ContentView.swift
//  How Big?
//
//  Created by User on 27/12/2024.
//

import SwiftUI

struct ContentView : View { // test commit
    var body: some View {
        TabView {
            
            Measure()
                .tabItem {
                    Image(systemName: "camera.fill")
                    Text("Measure")
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
    ContentView()
}
