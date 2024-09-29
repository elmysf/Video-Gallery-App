//
//  FontsExtension.swift
//  VideosEngine
//
//  Created by Sufiandy Elmy on 29/09/24.
//

import Foundation
import SwiftUI

public struct FontExtension {
    public init () {}
}

extension Font {
    public struct Fonts {
        public static func styleFont(_ style: NameFonts, size: CGFloat) -> Font {
            return Font.custom(style.name, size: size)
        }
    }
}
