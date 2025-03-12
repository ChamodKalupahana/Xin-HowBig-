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
        ZStack(alignment : .bottom){
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
//            if let length = referenceViewModel.referenceToMeasure?.length {
//                Text("\(coordinator.formatDistance(distance: length ))")
//                    .font(.title2)
//            }
            if let measurement = referenceViewModel.findUIStingForMeasurement() {
                Text(measurement)
                    .font(.title2)
            }
            
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
                    ReferenceObjectClickToSelectReference(referenceObject: referenceObject)
                        .environmentObject(referenceViewModel)
                    
                }
        }
        }
    }
    
    var saveButton : some View {
        ZStack{
            if (referenceViewModel.referenceToMeasure != nil) {
                Button {
                    let error = referenceViewModel.saveCurrentReference()
                    guard error != nil else {
                        
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
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 7.5))
                    .padding()
                    
                    
                }
            }
        }
    }
}

struct ReferenceObjectClickToSelectReference : View {
    @EnvironmentObject var referenceViewModel : ReferencesViewModel
    var referenceObject : ReferenceObject
    var body : some View {
        Button {
            withAnimation {
                referenceViewModel.selectedReference = referenceObject
            }
        } label: {
            ReferenceObjectCard(referenceObject: referenceObject)
        }
    }
}


struct ReferenceObjectCard : View {
    var referenceObject : ReferenceObject
    var body: some View {
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

#Preview {
    ReferencesScreen()
}
