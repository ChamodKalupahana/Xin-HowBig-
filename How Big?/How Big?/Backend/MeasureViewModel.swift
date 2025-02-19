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
    
    @Published var isShowingReferenceScreen : Bool = false
    @Published var referenceToMeasure : ReferenceObject = ReferenceObject(name: "New Reference", length: 0, image: Image(systemName : "testtube.2"), numberOfDimensions: 1, source: .personal)
    
    func addLength(inputLength : Float) {
        referenceToMeasure.length = inputLength
    }
    
    func showReferencesScreenWithReferenceToCreate() {
        // check dimensions
        
        
    }
}
