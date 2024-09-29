//
//  ContentView.swift
//  Video Gallery App
//
//  Created by Sufiandy Elmy on 29/09/24.
//

import SwiftUI

public struct ContentView: View {
    @AppStorage("showOnboarding") var showOnboarding: Bool = true
    @StateObject private var videoVM = VideosViewModel()
    @State private var isRedirectToHome: Bool = false
    
    public var body: some View {
        ZStack {
            if self.showOnboarding {
                OnboardingMainView(numberOfImages: 3, showOnboarding: $showOnboarding, isRedirectToHome: self.$isRedirectToHome) {
                    OnboardingOneView()
                    OnboardingTwoView()
                    OnboardingThreeView()
                }
            }else{
                NavigationStack{
                    ZStack {
                        AllVideosView(videoVM: self.videoVM)
                    }
                    .onAppear {
                        self.videoVM.fetchAllVideo()
                    }
                }
            }
        }
    }
}
