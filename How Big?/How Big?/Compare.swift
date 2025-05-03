//
//  Compare.swift
//  How Big?
//
//  Created by User on 02/05/2025.
//

import SwiftUI

struct Compare: View {
    var body: some View {
        VStack{
            
            Text("Compare")
            
            SceneViewController()
                .ignoresSafeArea()
        }
        .background(Color(.backgroundColor))
    }
}

#Preview {
    Compare()
}
