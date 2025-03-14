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
        ReferenceObject(name: "Apple", length: 0.05, image: Image(.apple), numberOfDimensions: 1, source: .preset),
        ReferenceObject(name: "Laptop", length: 0.30, image: Image(.laptop), numberOfDimensions: 1, source: .preset),
        ReferenceObject(name: "Football Stadium", length: 100, image: Image(.footballStadium), numberOfDimensions: 1, source: .preset),
        ReferenceObject(name: "Xin", length: 1.58, image: Image(.xin), numberOfDimensions: 1, source: .preset),
        ReferenceObject(name: "Cham", length: 1.85, image: Image(.cham), numberOfDimensions: 1, source: .preset),
        ReferenceObject(name: "Pecan", length: 0.02 , image: Image(.pecan), numberOfDimensions: 1, source: .preset),
        ReferenceObject(name: "Cham's foot", length: 2.50 , image: Image(.chamSFoot), numberOfDimensions: 1, source: .preset),
    ]
    
    @Published var selectedReference : ReferenceObject? = nil
    
    @Published var referenceToMeasure : ReferenceObject? = ReferenceObject(name: "New Reference", length: 0, image: Image(systemName: "lasso"), numberOfDimensions: 1, source: .preset)
    
    
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
    
    func addReferenceToList(referenceToAdd : ReferenceObject) {
        self.listOfReferences.append(referenceToAdd)
    }
    
    func saveCurrentReference() -> Error? {
        guard let referenceToMeasure else {
            return URLError(.fileDoesNotExist)
        }
        
        self.listOfReferences.append(referenceToMeasure)
        self.referenceToMeasure = nil
        
        
        
        return nil
    }
    
    func findHowBigMeasurementWithinClass() -> String? {
        guard let selectedReference, let referenceToMeasure else {
            return nil
        }
        
        guard referenceToMeasure.length != 0 else {
            return nil
        }
        
        let distanceToShow = self.referenceToMeasure!.length / selectedReference.length
        
        return "\(formatDistance(distance: distanceToShow)) \(selectedReference.name)s"
        
    }
    
    
    func initaliseNewObject(length : Float) {
        self.referenceToMeasure = ReferenceObject(name: "New Reference", length: length, image: Image(systemName: "lasso"), numberOfDimensions: 1, source: .preset)
    }
    
}
