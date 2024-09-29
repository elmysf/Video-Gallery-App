//
//  VideoCardView.swift
//  Video Gallery App
//
//  Created by Sufiandy Elmy on 29/09/24.
//


import SwiftUI
import DesignSystemKit

struct VideoCardView: View {
    
    var video: GetAllVideosModel
    
    var body: some View {
        ZStack {
            ZStack(alignment: .bottomLeading) {
                Image.imgOne
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 180, height: 250)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isNewVideo() ? Color.red : Color.white, lineWidth: 2)
                    )
                    .shadow(radius: 5)
                
                if isNewVideo() {
                    Text("New Video")
                        .font(.Fonts.styleFont(.DMSansBold, size: 16))
                        .foregroundColor(Color.white)
                        .padding(8)
                        .background(Color.red.opacity(0.7))
                        .cornerRadius(8)
                        .padding(8)
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    private func isNewVideo() -> Bool {
        let dateFormatter = ISO8601DateFormatter()
        guard let uploadDate = dateFormatter.date(from: video.uploadDate) else {
            return false
        }
        let currentDate = Date()
        return uploadDate >= currentDate.addingTimeInterval(-10 * 60)
    }
}

