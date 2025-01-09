//
//  Measure.swift
//  How Big?
//
//  Created by User on 27/12/2024.
//

import SwiftUI

struct Measure: View {
    @State var isShowingReferenceScreen : Bool = false
    var body: some View {
        NavigationStack{
            ZStack(alignment : .bottom){
                ARController()
                
                calculateButton
            }
            .navigationTitle("Xin's How Big?")
            
            
        }
    }
    
    var calculateButton : some View {
        ZStack{
            Button {
                isShowingReferenceScreen = true
            } label: {
                HStack{
                    Image(systemName: "function")
                    Text("Calculate")
                }
                .foregroundStyle(Color.white)
                .padding()
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 7.5))
                .padding(.bottom, 20)
                
            }

        }
    }
}

#Preview {
    ContentView()
}
