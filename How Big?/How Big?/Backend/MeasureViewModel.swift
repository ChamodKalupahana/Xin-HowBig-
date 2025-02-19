//
//  MeasureViewModel.swift
//  How Big?
//
//  Created by User on 19/02/2025.
//

import Foundation
import SwiftUI

class MeasureViewModel : ObservableObject {
    
    static let shared = MeasureViewModel()
    let referencesViewModel = ReferencesViewModel.shared
    let coordinator = Coordinator.shared
    
    @Published var isShowingReferenceScreen : Bool = false
    @Published var referenceToMeasure : ReferenceObject = ReferenceObject(name: "New Reference", length: 0, image: Image(systemName : "testtube.2"), numberOfDimensions: 1, source: .personal)
    
    func addMeasurementAndDimensionToObject(measurement : Float?) {
        if (self.referenceToMeasure.length == 0) {
            self.referenceToMeasure.length = measurement ?? 0
            coordinator.resetPoints()
            return
        }
        
        if (self.referenceToMeasure.height == nil) {
            self.referenceToMeasure.height = measurement
            self.referenceToMeasure.numberOfDimensions = 2
            coordinator.resetPoints()
            return
        }
        
        if (self.referenceToMeasure.width == nil) {
            self.referenceToMeasure.width = measurement
            self.referenceToMeasure.numberOfDimensions = 3
            coordinator.resetPoints()
            return
        }
        
        coordinator.resetPoints()
        
    }
    
    func showReferencesScreenWithReferenceToCreate(lastMeasurementToAdd : Float?) {
        // add in last input
        addMeasurementAndDimensionToObject(measurement: lastMeasurementToAdd)
    
        referencesViewModel.referenceToMeasure = self.referenceToMeasure
        self.referenceToMeasure = ReferenceObject(name: "New Reference", length: 0, image: Image(systemName : "testtube.2"), numberOfDimensions: 1, source: .personal)
        isShowingReferenceScreen = true
        
    }
    
    func canAddMoreDimensionsWithoutShowingReferenceScreen() -> Bool {
        return self.referenceToMeasure.numberOfDimensions < 2
    }
}
