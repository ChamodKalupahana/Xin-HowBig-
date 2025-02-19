//
//  ProfileViewModel.swift
//  How Big?
//
//  Created by User on 18/02/2025.
//

import Foundation

class ProfileViewModel : ObservableObject {
    static let shared = ProfileViewModel()
    
    @Published var selectedSource : ReferenceObjectSource = .personal
    @Published var selectedDimesion : ReferenceObjectDimensionFilters = .
}
