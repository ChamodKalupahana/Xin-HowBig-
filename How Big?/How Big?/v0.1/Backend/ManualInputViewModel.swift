//
//  ManualInputViewModel.swift
//  How Big?
//
//  Created by User on 18/02/2025.
//

import Foundation
import SwiftUI

class ManualInputViewModel : ObservableObject {
    static let shared = ManualInputViewModel()
    let referenceViewModel = ReferencesViewModel.shared
    
    @Published var referenceToCreate : ReferenceObject = ReferenceObject(name: "New Reference", length: 0, image: Image(systemName : "testtube.2"), numberOfDimensions: 1, source: .personal)
    
    @Published var isShowingReferencesScreen : Bool = false
    @Published var focusedField : PossibleInputs? = nil
    
    @Published var selectedHeight : Float = 0
    @Published var selectedWidth : Float = 0
    
    enum PossibleInputs : Hashable {
        case length, width, height, name
    }
    
    func createReference() {
        
        if (referenceToCreate.height != nil) {
            referenceToCreate.numberOfDimensions += 1
        }
        
        if (referenceToCreate.width != nil) {
            referenceToCreate.numberOfDimensions += 1
        }
        
        referenceViewModel.addReferenceToList(referenceToAdd: referenceToCreate)
        
        referenceToCreate = ReferenceObject(name: "New Reference", length: 0, image: Image(systemName : "testtube.2"), numberOfDimensions: 1, source: .personal)
        isShowingReferencesScreen = true
    }
    
    func showReferencesScreenWithReferenceToCreate() {
        if (selectedHeight != 0) {
            referenceToCreate.numberOfDimensions += 1
            referenceToCreate.height = selectedHeight
        }
        
        if (selectedWidth != 0) {
            referenceToCreate.numberOfDimensions += 1
            referenceToCreate.width = selectedWidth
        }
        
        isShowingReferencesScreen = true
        referenceViewModel.referenceToMeasure = referenceToCreate
    }
    
    func resetReferenceToCreateAndInputVariables() {
        referenceToCreate = ReferenceObject(name: "New Reference", length: 0, image: Image(systemName : "testtube.2"), numberOfDimensions: 1, source: .personal)
        selectedWidth = 0
        selectedHeight = 0
    }
}
