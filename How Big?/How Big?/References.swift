//
//  References.swift
//  How Big?
//
//  Created by User on 09/01/2025.
//

import SwiftUI

struct ReferencesScreen: View {
    @EnvironmentObject var coordinator : Coordinator
    @StateObject var referenceViewModel = ReferencesViewModel.shared
    var body: some View {
        HStack{
            
            // measurements
            calculation
            
            // references
            
        }
    }
    
    var calculation : some View {
        VStack{
            Text("Measurement")
            if let selectedDistance = coordinator.selectedDistance {
                Text("\(selectedDistance)")
                    .font(.title2)
            }
            
            Text("How Big?")
            
            
        }
        .font(.title)
    }
    
    var references : some View {
        VStack{
            ForEach(referenceViewModel.listOfReferences) { referenceObject in
                Text("\(referenceObject.name)")
                
            }
        }
    }
}

#Preview {
    ReferencesScreen()
}
