//
//  NameFonts.swift
//  VideosEngine
//
//  Created by Sufiandy Elmy on 29/09/24.
//

import SwiftUI

public struct NameFonts : Sendable{
    public let name: String
    
    private init(named name: String) {
        self.name = name
        do {
            try registerFont(named: name)
        } catch {
            let reason = error.localizedDescription
            fatalError("Failed to register font: \(reason)")
        }
    }
    
    // DM Sans fonts
    @MainActor public static let DMSansBold = NameFonts(named: "DMSans-Bold")
    @MainActor public static let DMSansMedium = NameFonts(named: "DMSans-Bold")
    @MainActor public static let DMSansRegular = NameFonts(named: "DMSans-Bold")
}
