//
//  ManualInput.swift
//  How Big?
//
//  Created by User on 18/02/2025.
//

import SwiftUI

struct ManualInput: View {
    @State var referencesViewModel = ReferencesViewModel.shared
    var body: some View {
        VStack{
            
            // title
            
            // inputs
            
        }
        
    }
    
    var measurements : some View {
        VStack {
            
            HStack {
                Text("Length")
                TextField("Reqiuried", value: <#T##Binding<_?>#>)
            }
        }
    }
}

#Preview {
    ManualInput()
}
