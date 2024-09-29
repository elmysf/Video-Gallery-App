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
    guard let asset = NSDataAsset(name: "Fonts/\(name)", bundle: Bundle.module) else {
        throw FontError.failedToRegisterFont
    }
    let fontData = asset.data as CFData
    guard let fontDescriptors = CTFontManagerCreateFontDescriptorsFromData(fontData) as? [CTFontDescriptor],
          !fontDescriptors.isEmpty else {
        throw FontError.failedToRegisterFont
    }
    
    let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(name)
    
    do {
        try asset.data.write(to: tempURL)
        var error: Unmanaged<CFError>?
        let success = CTFontManagerRegisterFontsForURL(tempURL as CFURL, .process, &error)
        
        if !success {
            throw FontError.failedToRegisterFont
        }
    } catch {
        throw FontError.failedToRegisterFont
    }
}
