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
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack{
            
            // title
            
            // inputs
            measurements
            
            // confirm button
        }
        
    }
    
    var measurements : some View {
        
        VStack {
            
            HStack {
                Text("Length")
                TextField("Reqiuried", value: $manualInputViewModel.referenceToCreate.length, formatter: formatter)
            }
        }
    }
    
    var saveButton : some View {
        ZStack{
            Button {
                manualInputViewModel.createReference()
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
