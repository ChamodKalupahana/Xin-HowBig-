//
//  DataStructures.swift
//  How Big?
//
//  Created by User on 09/01/2025.
//

import Foundation
import SwiftUI

struct ReferenceObject : Identifiable{
    var id : String = UUID().uuidString
    var name : String
    var length : Float
    var image : Image
    var numberOfDimensions : Int
    
    var height : Float?
    var width : Float?
    
    var source : ReferenceObjectSource
    
}

enum ReferenceObjectSource : CaseIterable {
    case preset, personal, seasonal, sponsored
    
    var toUIString : String {
        switch self {
        case .preset:
            return "Default"
        case .personal:
            return "Personal"
        case .seasonal:
            return "Seasonal"
        case .sponsored:
            return "Sponsered"
        }
    }
}

enum ReferenceObjectDimensionFilters : CaseIterable {
    case one, two, three, all
    
    var toUIString : String {
        switch self {
        case .one:
            return "1D"
        case .two:
            return "2D"
        case .three:
            return "3D"
        case .all:
            return "All"
        }
    }
}
