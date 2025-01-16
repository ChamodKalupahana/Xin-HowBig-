//
//  References.swift
//  How Big?
//
//  Created by User on 09/01/2025.
//

import SwiftUI

struct ReferencesScreen: View {
    @StateObject var coordinator : Coordinator = Coordinator.shared
    @StateObject var referenceViewModel = ReferencesViewModel.shared
    var body: some View {
        HStack{
            
            // measurements
            calculation
            
            // references
            references
            
        }
    }
    
    var calculation : some View {
        VStack(spacing : 20 ){
            Text("Measurement")
            if let selectedDistance = coordinator.selectedDistance {
                Text("\(coordinator.formatDistance(distance: selectedDistance))")
                    .font(.title2)
            }
            
            Text("How Big?")
            if let howBigMeasurement = referenceViewModel.findHowBigMeasurement(selectedDistance: coordinator.selectedDistance) {
                Text("\(howBigMeasurement)")
                    .multilineTextAlignment(.center)
                    .font(.title2)
            }
            
            }
        .font(.largeTitle)
        .padding()
            
        }
        

    
    var references : some View {
        ScrollView{
            VStack{
                ForEach(referenceViewModel.listOfReferences) { referenceObject in
                    ReferenceObjectCard(referenceObject: referenceObject)
                        
                        .environmentObject(referenceViewModel)
                    
                }
        }
        }
    }
}

struct ReferenceObjectCard : View {
    @EnvironmentObject var referenceViewModel : ReferencesViewModel
    var referenceObject : ReferenceObject
    var body : some View {
        Button {
            withAnimation {
                referenceViewModel.selectedReference = referenceObject
            }
        } label: {
            VStack{
                referenceObject.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(Color.white)
                    .padding(2)
                    .frame(width: 90, height: 90)
                    .padding(8)
                    .background(Color.black)
                    .padding(2)
                    .background(Color.white)
                
                
                Text("\(referenceObject.name)")
                    .foregroundStyle(Color.primary)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    ReferencesScreen()
}
