//
//  ManualInput.swift
//  How Big?
//
//  Created by User on 18/02/2025.
//

import SwiftUI

struct ManualInput: View {
    @StateObject var referencesViewModel = ReferencesViewModel.shared
    @StateObject var manualInputViewModel = ManualInputViewModel.shared
    
    
    @FocusState private var focusField: ManualInputViewModel.PossibleInputs?
    @StateObject var coordinator = Coordinator.shared
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = false
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    
    
    var body: some View {
        ScrollView{
            VStack{
                
                // title
                title
                
                // inputs
                measurements
                
                // confirm button
                saveButton
                
                .sheet(isPresented: $manualInputViewModel.isShowingReferencesScreen) {
                    ReferencesScreen()
                        .environmentObject(coordinator)
                }
            }
        }
    }
    
    var title : some View {
        HStack {
            HStack {
                Text("Name")
                    .font(.headline)
                TextField("Name", text: $manualInputViewModel.referenceToCreate.name)
                    .keyboardType(.default)
                    .focused($focusField, equals: .name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
        }
    }
    
    var measurements : some View {
        
        VStack {
            
            HStack {
                Text("Length")
                    .font(.headline)
                TextField("Required", value: $manualInputViewModel.referenceToCreate.length, formatter: formatter)
                    .keyboardType(.decimalPad)
                    .focused($focusField, equals: .length)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            
            
            HStack {
                Text("Height")
                    .font(.title2)
                TextField("Optional", value: $manualInputViewModel.selectedHeight, formatter: formatter)
                    .keyboardType(.decimalPad)
                    .focused($focusField, equals: .length)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            
            HStack {
                Text("Width")
                    .font(.title2)
                TextField("Optional", value: $manualInputViewModel.selectedWidth, formatter: formatter)
                    .keyboardType(.decimalPad)
                    .focused($focusField, equals: .length)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
        }
        .padding(20)
    }
        
    
    var saveButton : some View {
        ZStack{
            Button {
                manualInputViewModel.showReferencesScreenWithReferenceToCreate()
                manualInputViewModel.resetReferenceToCreateAndInputVariables()
                focusField = nil
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

#Preview {
    ManualInput()
}
