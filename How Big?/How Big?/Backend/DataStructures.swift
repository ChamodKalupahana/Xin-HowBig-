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
            return "Sponsored"
        }
    }
}

enum ReferenceObjectDimensionFilters : CaseIterable {
    case all ,one, two, three
    
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
    
    var toInt : Int {
        switch self {
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        case .all:
            return 0
        }
    }
    
    func filterByDimension(inputDimension: Int) -> Bool {
        if self == .all {
            return true
        }
        return self.toInt == inputDimension
    }
}

enum Dimension {
    case x, y, z
}

enum CameraControlMethod {
    case tapToFocus, doubleDragToPan, toggleRotateAndPan
}
