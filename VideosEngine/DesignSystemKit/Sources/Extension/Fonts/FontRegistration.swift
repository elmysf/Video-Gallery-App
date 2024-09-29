//
//  FontRegistration.swift
//  VideosEngine
//
//  Created by Sufiandy Elmy on 29/09/24.
//

import UIKit
import CoreGraphics
import CoreText

public enum FontError: Swift.Error {
    case failedToRegisterFont
}

func registerFont(named name: String) throws {
    guard let fontURL = Bundle.module.url(forResource: name, withExtension: nil, subdirectory: "Fonts") else {
        throw FontError.failedToRegisterFont
    }
    
    var fontError: Unmanaged<CFError>?
    let success = CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &fontError)
    
    if !success, let error = fontError?.takeRetainedValue() {
        print("Failed to register font: \(error.localizedDescription)")
        throw FontError.failedToRegisterFont
    }
}
