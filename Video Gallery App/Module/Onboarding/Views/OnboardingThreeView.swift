//
//  OnboardingThreeView.swift
//  Video Gallery App
//
//  Created by Sufiandy Elmy on 29/09/24.
//


import SwiftUI
import DesignSystemKit

struct OnboardingThreeView: View {
    @State private var isAnimating: Bool = false
    @State private var deviceHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Image.imgThree
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width)
                    .edgesIgnoringSafeArea(.all)
            }
        
            VStack(alignment: .center, spacing: 8){
                OnboardingText
            }
            .frame(maxWidth: .infinity,maxHeight: 500, alignment: .bottom)
            .padding(.horizontal, 24)
            .padding(.bottom, deviceHeight < 680 ? 100 : UIScreen.main.bounds.height / 6)
        }
        .onAppear{
            isAnimating = false
            withAnimation(.easeOut(duration: 0.5)) {
                self.isAnimating = true
            }
        }
    }
}

extension OnboardingThreeView{
    @ViewBuilder private var OnboardingText: some View{
        HStack(spacing: 0){
            Text("Endless Inspiration!")
                .font(.Fonts.styleFont(.DMSansBold, size: 24))
                .foregroundColor(Color.white)
        }
    }
}
