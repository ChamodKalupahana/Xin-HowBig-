//
//  Compare.swift
//  How Big?
//
//  Created by User on 02/05/2025.
//

import SwiftUI

struct Compare: View {
    var body: some View {
        ZStack{
            SceneViewController()
                .ignoresSafeArea()
            
            VStack(alignment: .leading){
                Text("How Big?")
                    .font(.customLargeTitle)
//                    .fontWeight(.bold)
                
                Spacer()
                
                Text("This is house is 15m long, 10x longer than the plant")
                    .font(.customHeadline)
            }
            .padding()
        }
        .background(Color(.background))
    }
}

#Preview {
    Compare()
}
