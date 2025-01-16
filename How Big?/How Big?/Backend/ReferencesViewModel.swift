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
        ReferenceObject(name: "Apple", length: 0.05, image: Image(.apple)),
        ReferenceObject(name: "Laptop", length: 0.30, image: Image(.laptop)),
        ReferenceObject(name: "Football Stadium", length: 100, image: Image(.footballStadium)),
        ReferenceObject(name: "Xin", length: 1.58, image: Image(.xin)),
        ReferenceObject(name: "Cham", length: 1.85, image: Image(.cham)),
        ReferenceObject(name: "Pecan", length: 0.02 , image: Image(.pecan)),
    ]
    
    @Published var selectedReference : ReferenceObject? = nil
    
    func findHowBigMeasurement(selectedDistance : Float?) -> String? {
        guard let selectedDistance, let selectedReference else {
            return nil
        }
        let distanceToShow = selectedDistance / selectedReference.length
        
        return "\(formatDistance(distance: distanceToShow)) \(selectedReference.name)s"
        
    }
    
    func formatDistance(distance : Float) -> String {
        return String(format: "%.2f", distance)
    }
    
}
