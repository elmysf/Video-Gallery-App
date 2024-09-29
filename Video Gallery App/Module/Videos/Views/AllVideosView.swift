//
//  AllVideosView.swift
//  Video Gallery App
//
//  Created by Sufiandy Elmy on 29/09/24.
//


import SwiftUI
import DesignSystemKit
import AVFoundation
import AVKit

struct AllVideosView: View {
    @ObservedObject var videoVM: VideosViewModel
    @State private var isPreviewPresented: Bool = false
    @State private var isShowPhotoLibrary: Bool = false
    @State private var isShowCamera: Bool = false
    @State private var videoToDelete: GetAllVideosModel? = nil
    @State private var showDeleteConfirmation: Bool = false
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]

    var body: some View {
        ZStack {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(videoVM.listVideo, id: \.publicID) { item in
                            VStack {
                                NavigationLink(destination: VideoPlayerView(video: item)) {
                                    VideoCardView(video: item)
                                }
                                Button(action: {
                                    self.videoToDelete = item
                                    self.showDeleteConfirmation = true
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                        .padding(8)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)

            if videoVM.listVideo.isEmpty {
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            } else if !videoVM.listVideo.isEmpty {
                VStack {
                    Spacer()
                    if isPreviewPresented {
                        FloatingActionButton(icon: "camera.aperture", color: .mint) {
                            self.isShowCamera = true
                        }
                        FloatingActionButton(icon: "folder.circle", color: .green) {
                            self.isShowPhotoLibrary = true
                        }
                    }
                    FloatingActionButton(icon: "plus", color: .purple) {
                        withAnimation {
                            isPreviewPresented.toggle()
                        }
                    }
                    .rotationEffect(.degrees(isPreviewPresented ? 45 : 0))
                    .animation(.spring(), value: isPreviewPresented)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 16)
            }
        }
        .sheet(isPresented: $isShowCamera) {
            VideoRecordingViews(isShown: $isShowCamera, videoURL: $videoVM.videoURL)
                .onDisappear {
                    if let videoURL = videoVM.videoURL, FileManager.default.fileExists(atPath: videoURL.path) {
                        let publicID = UUID().uuidString
                        self.videoVM.uploadVideo(videoURL: videoURL, publicID: publicID)
                    } else {
                        print("No valid video was captured.")
                    }
                }
        }
        // Photo Library Picker Sheet
        .sheet(isPresented: $isShowPhotoLibrary) {
            VideoGalleryPickerView(sourceType: .photoLibrary, isShown: $isShowPhotoLibrary, selectedVideo: self.$videoVM.videoURL)
                .onDisappear {
                    if let videoURL = videoVM.videoURL, FileManager.default.fileExists(atPath: videoURL.path) {
                        let publicID = UUID().uuidString
                        self.videoVM.uploadVideo(videoURL: videoURL, publicID: publicID)
                    } else {
                        print("No valid video was selected.")
                    }
                }
        }
        .confirmationDialog("Are you sure you want to delete this video?", isPresented: $showDeleteConfirmation, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                if let videoToDelete = videoToDelete {
                    DispatchQueue.main.async {
                        videoVM.deleteVideo(publicID: videoToDelete.publicID)
                    }
                    self.videoToDelete = nil
                }
            }
            Button("Cancel", role: .cancel) {
                videoToDelete = nil
            }
        }
    }
}
