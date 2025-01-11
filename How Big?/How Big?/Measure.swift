//
//  Measure.swift
//  How Big?
//
//  Created by User on 27/12/2024.
//

import SwiftUI

struct Measure: View {
    @StateObject var coordinator = Coordinator.shared
    
    @State var isShowingReferenceScreen : Bool = false
    var body: some View {
        NavigationStack{
            ZStack(alignment : .bottom){
                ARController()
                
                calculateButton
            }
            .navigationTitle("Xin's How Big?")
            
            .sheet(isPresented: $isShowingReferenceScreen) {
                ReferencesScreen()
                    .environmentObject(coordinator)
            }
        }
    }
    
    var calculateButton : some View {
        ZStack{
            if coordinator.selectedDistance != nil {
                Button {
                    isShowingReferenceScreen = true
                } label: {
                    HStack{
                        Image(systemName: "function")
                        Text("How Big?")
                    }
                    .foregroundStyle(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 7.5))
                    .padding()
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
