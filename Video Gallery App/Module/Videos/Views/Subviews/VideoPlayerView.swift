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
                    .task {
                        self.videoVM.player = AVPlayer(url: URL(string: video.url)!)
                    }
            }
        }
        .onAppear {
            self.videoVM.loadVideo(url: video.url)
        }
    }
}