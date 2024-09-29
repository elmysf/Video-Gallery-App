//
//  VideoPlayerView.swift
//  Video Gallery App
//
//  Created by Sufiandy Elmy on 29/09/24.
//


import SwiftUI
import AVKit

struct VideoPlayerView: View {
    var video: GetAllVideosModel
    @StateObject private var videoVM = VideosViewModel()
    
    var body: some View {
        ZStack {
            if let player = videoVM.player {
                VideoPlayer(player: player)
                    .ignoresSafeArea(.all)
            }
        }
        .onAppear {
            self.videoVM.loadVideo(url: video.videoURLString)
        }
    }
}