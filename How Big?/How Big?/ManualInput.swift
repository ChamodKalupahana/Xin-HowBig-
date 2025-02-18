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
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    
    
    var body: some View {
        VStack{
            
            // title
            
            // inputs
            measurements
            
            // confirm button
            saveButton
        }
        
    }
    
    var measurements : some View {
        
        VStack {
            
            HStack {
                Text("Length")
                    .font(.headline)
                TextField("Required", value: $manualInputViewModel.referenceToCreate.length, formatter: formatter)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            .focused($focusField, equals: .length)
        }
        .padding(20)
        .background(Color.gray)
    }
        
    
    var saveButton : some View {
        ZStack{
            Button {
                manualInputViewModel.createReference()
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
