//
//  ContentView.swift
//  How Big?
//
//  Created by User on 27/12/2024.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        TabView {
            
            Measure()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Measure")
                }

        }
    }

}

#Preview {
    ContentView()
}
