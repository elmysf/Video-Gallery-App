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
        ZStack{
            ZStack(alignment: .bottomLeading){
                Image.imgOne
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 160, height: 250)
                    .cornerRadius(30)
            }
            .padding(.horizontal, 16)
            
            Image(systemName: "play.fill")
                .foregroundColor(.white)
                .font(.title)
                .padding()
                .background(.purple)
                .cornerRadius(50)
        }
    }
}