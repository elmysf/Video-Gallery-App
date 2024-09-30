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
    let randomImages = [Image.imgOne, Image.imgTwo, Image.imgThree]
    
    var body: some View {
        ZStack {
            ZStack(alignment: .bottomLeading) {
                randomImages.randomElement()?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 180, height: 250)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(video.isNew ? Color.red : Color.white, lineWidth: 2)
                    )
                    .shadow(radius: 5)
                
                if video.isNew {
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
            
            Image(systemName: "play.circle")
                .foregroundColor(.white)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(50)
        }
    }
}

