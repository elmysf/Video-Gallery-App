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
    @State private var videoToDelete: GetAllVideosModel? = nil
    
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 16)]

    var body: some View {
        ZStack {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(videoVM.listVideo, id: \.publicID) { item in
                            VStack {
                                NavigationLink(destination: VideoPlayerView(video: item)) {
                                    VideoCardView(video: item)
                                        .contextMenu {
                                            Button("Delete Video") {
                                                self.videoToDelete = item
                                                self.videoVM.showDeleteConfirmation = true
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)

            if videoVM.isDeleting {
                ProgressView("Deleting...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .edgesIgnoringSafeArea(.all)
            } else if videoVM.isLoadingAfterUpload {
                ProgressView("Uploading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.5))
                    .edgesIgnoringSafeArea(.all)
            } else if videoVM.isLoading {
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
                    if self.videoVM.isPreviewPresented {
                        FloatingActionButton(icon: "camera.aperture", color: .mint) {
                            self.videoVM.isShowCamera = true
                        }
                        FloatingActionButton(icon: "folder.circle", color: .green) {
                            self.videoVM.isShowPhotoLibrary = true
                        }
                    }
                    FloatingActionButton(icon: "plus", color: .purple) {
                        withAnimation {
                            self.videoVM.isPreviewPresented.toggle()
                        }
                    }
                    .rotationEffect(.degrees(self.videoVM.isPreviewPresented ? 45 : 0))
                    .animation(.spring(), value: self.videoVM.isPreviewPresented)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 16)
            }
        }
        .fullScreenCover(isPresented: $videoVM.isShowCamera) {
            VideoRecordingViews(isShown: $videoVM.isShowCamera, isPreviewPresented: $videoVM.isPreviewPresented, videoURL: $videoVM.videoURL)
                .onDisappear {
                    if let videoURL = videoVM.videoURL, FileManager.default.fileExists(atPath: videoURL.path) {
                        let publicID = UUID().uuidString
                        self.videoVM.isLoadingAfterUpload = true
                        self.videoVM.uploadVideo(videoURL: videoURL, publicID: publicID) {}
                    }
                }
        }
        .fullScreenCover(isPresented: $videoVM.isShowPhotoLibrary) {
            VideoGalleryPickerView(sourceType: .photoLibrary, isShown: $videoVM.isShowPhotoLibrary, isPreviewPresented: $videoVM.isPreviewPresented, selectedVideo: self.$videoVM.videoURL)
                .onDisappear {
                    if let videoURL = videoVM.videoURL, FileManager.default.fileExists(atPath: videoURL.path) {
                        let publicID = UUID().uuidString
                        self.videoVM.isLoadingAfterUpload = true
                        self.videoVM.uploadVideo(videoURL: videoURL, publicID: publicID) {}
                    }
                }
        }
        .confirmationDialog("Are you sure you want to delete this video?", isPresented: $videoVM.showDeleteConfirmation, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                if let videoToDelete = videoToDelete {
                    self.videoVM.isDeleting = true
                    videoVM.deleteVideo(publicID: videoToDelete.publicID) {}
                    self.videoToDelete = nil
                }
            }
            Button("Cancel", role: .cancel) {
                videoToDelete = nil
            }
        }
        .alert(isPresented: $videoVM.showSuccessDeleteAlert) {
            Alert(title: Text("Success"), message: Text("Video deleted successfully!"), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $videoVM.showSuccessUploadAlert) {
            Alert(title: Text("Success"), message: Text("Video uploaded successfully!"), dismissButton: .default(Text("OK")))
        }
    }
}
