//
//  Measure.swift
//  How Big?
//
//  Created by User on 27/12/2024.
//

import SwiftUI

struct Measure: View {
    @StateObject var coordinator = Coordinator.shared
    @StateObject var referencesViewModel = ReferencesViewModel.shared
    @StateObject var measureViewModel = MeasureViewModel.shared


    var body: some View {
        NavigationStack{
            ZStack(alignment : .bottom){
                ARController()
                
                calculateButtons
            }
            .navigationTitle("Xin's How Big?")
            
            .sheet(isPresented: $measureViewModel.isShowingReferenceScreen) {
                ReferencesScreen()
                    .environmentObject(coordinator)
            }
        }
    }
    
    var calculateButtons : some View {
        ZStack{
            if coordinator.selectedDistance != nil {
                HStack{
                    
                    if (measureViewModel.canAddMoreDimensionsWithoutShowingReferenceScreen()) {
                        Button {
                            measureViewModel.addMeasurementAndDimensionToObject(measurement: coordinator.selectedDistance)
                        } label: {
                            HStack{
                                Image(systemName: "plus")
                                Text("Add Dimension")
                            }
                            .foregroundStyle(Color.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 7.5))
                            .padding()
                            
                        }
                    }
                    
                    Button {
                        measureViewModel.showReferencesScreenWithReferenceToCreate(lastMeasurementToAdd: coordinator.selectedDistance)
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
    
    var howBigFunShapeButton : some View {
        ZStack{
            if coordinator.selectedDistance != nil {
                Button {
                    referencesViewModel.referenceToMeasure?.length = coordinator.selectedDistance!
                    measureViewModel.isShowingReferenceScreen = true
                } label: {
                    HStack{
                        Image(systemName: "carrot.fill")
                        Text("How Big?")
                    }
                    .foregroundStyle(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red.brightness(0.7))
                    
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
