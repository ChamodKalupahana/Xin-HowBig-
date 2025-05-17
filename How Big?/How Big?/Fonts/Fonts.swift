//
//  Fonts.swift
//  How Big?
//
//  Created by User on 17/05/2025.
//

import Foundation
import SwiftUI

let customFontName: String = "Xinfont20-Regular"

extension Font {
    static let customLargeTitle = Font.custom(customFontName, size: 36, relativeTo: .largeTitle)
    static let customTitle = Font.custom(customFontName, size: 28, relativeTo: .title)
    static let customHeadline = Font.custom(customFontName, size: 24, relativeTo: .headline)
    static let customBody = Font.custom(customFontName, size: 18, relativeTo: .body)
    static let customSubheadline = Font.custom(customFontName, size: 16, relativeTo: .subheadline)
    static let customCaption = Font.custom(customFontName, size: 14, relativeTo: .caption)
}
