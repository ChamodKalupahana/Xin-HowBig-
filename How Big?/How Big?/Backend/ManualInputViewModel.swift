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
    
    @Published var referenceToCreate : ReferenceObject = ReferenceObject(name: "New Reference", length: 0, image: Image(systemName : "testtube.2"), numberOfDimensions: 1)
}
