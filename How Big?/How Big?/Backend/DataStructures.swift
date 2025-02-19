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
    
    var source : ReferenceObjectSource = .preset
    
}

enum ReferenceObjectSource {
    case preset, personal, seasonal, sponsored
}
