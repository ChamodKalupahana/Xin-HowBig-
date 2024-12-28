//
//  Measure.swift
//  How Big?
//
//  Created by User on 27/12/2024.
//

import SwiftUI

struct Measure: View {
    var body: some View {
        NavigationStack{
            VStack{
                ARController()
            }
            .navigationTitle("Xin's How Big?")
        }
    }
}

#Preview {
    Measure()
}
