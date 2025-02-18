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
    
    @Published var referenceToCreate : ReferenceObject = ReferenceObject(name: "New Reference", length: 0, image: Image(systemName : "testtube.2"), numberOfDimensions: 1)
    
    @Published var isShowingReferencesScreen : Bool = false
    
    func createReference() {
        referenceViewModel.addReferenceToList(referenceToAdd: referenceToCreate)
        referenceToCreate = ReferenceObject(name: "New Reference", length: 0, image: Image(systemName : "testtube.2"), numberOfDimensions: 1)
        isShowingReferencesScreen = true
    }
}
