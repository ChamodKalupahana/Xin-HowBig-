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
        ZStack{
            HStack{
                
                // measurements
                calculation
                
                // references
                references
                
            }
            
            // save button
            saveButton
        }
    }
    
    var calculation : some View {
        VStack(spacing : 20 ){
            Text("Measurement")
            Text("\(coordinator.formatDistance(distance: referenceViewModel.referenceToMeasure.length ))")
                .font(.title2)
            
            Text("How Big?")
            if let howBigMeasurement = referenceViewModel.findHowBigMeasurementWithinClass() {
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
    
    var saveButton : some View {
        Button {
            let error = referenceViewModel.saveCurrentReference()
            guard let error else {
                
                return
            }
        } label: {
            HStack{
                Image(systemName: "square.and.arrow.down")
                Text("Save as Reference")
            }
            .foregroundStyle(Color.white)
            .padding()
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red.brightness(0.7))
            
            
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
            ZStack (alignment : .bottomTrailing){
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
                
                Text("\(referenceObject.numberOfDimensions)D")
                    .font(.caption)
                    .padding(10)
            }
        }
    }
}

#Preview {
    ReferencesScreen()
}
