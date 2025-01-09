//
//  ReferencesViewModel.swift
//  How Big?
//
//  Created by User on 09/01/2025.
//

import Foundation
import SwiftUI

class ReferencesViewModel : ObservableObject {
    static let shared = ReferencesViewModel()
    
    @Published private(set) var listOfReferences : [ReferenceObject] = [
        ReferenceObject(name: "Apple", length: 0.05, image: Image(systemName: "applelogo")),
        ReferenceObject(name: "Laptop", length: 0.30, image: Image(systemName: "laptopcomputer")),
        ReferenceObject(name: "Football Stadium", length: 100, image: Image(.footBallStadium)),
        ReferenceObject(name: "Xin", length: 1.60, image: Image(.art)),
    ]
    
    @Published private(set) var selectedReference : ReferenceObject? = nil
    
}
