//
//  FloatingActionButton.swift
//  VideosEngine
//
//  Created by Sufiandy Elmy on 29/09/24.
//

import SwiftUI

public struct FloatingActionButton: View {
    
    public init(icon: String, color: Color, action: @escaping () -> Void) {
        self.icon = icon
        self.color = color
        self.action = action
    }
    
    public var icon: String
    public var color: Color
    public var action: () -> Void

    public var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.Fonts.styleFont(.DMSansRegular, size: 24))
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(color)
                .clipShape(Circle())
                .shadow(radius: 10)
        }
    }
}
