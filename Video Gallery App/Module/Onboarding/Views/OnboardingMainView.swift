//
//  OnboardingMainView.swift
//  Video Gallery App
//
//  Created by Sufiandy Elmy on 29/09/24.
//


import SwiftUI
import DesignSystemKit
import Combine

struct OnboardingMainView<Content: View>: View {
    
    private var numberOfImages: Int
    private var content: Content
    @Binding var showOnboarding: Bool
    @Binding var isRedirectToHome: Bool
    @State var slideGesture: CGSize = CGSize.zero
    @State private var currentIndex: Int = 0
    @State private var deviceHeight = UIScreen.main.bounds.size.height
    
    
    
    init(numberOfImages: Int, showOnboarding: Binding<Bool>, isRedirectToHome: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.numberOfImages = numberOfImages
        self._showOnboarding = showOnboarding
        self._isRedirectToHome = isRedirectToHome
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                HStack(spacing: 0) {
                    self.content
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
                .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
                .animation(.linear, value: currentIndex)
                .gesture(DragGesture().onChanged{ value in
                    self.slideGesture = value.translation
                }
                .onEnded{ value in
                    if self.slideGesture.width < -50 {
                        if self.currentIndex < self.numberOfImages - 1 {
                            withAnimation {
                                self.currentIndex += 1
                            }
                        }
                    }
                    if self.slideGesture.width > 50 {
                        if self.currentIndex > 0 {
                            withAnimation {
                                self.currentIndex -= 1
                            }
                        }
                    }
                    self.slideGesture = .zero
                })
                
                VStack(alignment: .center, spacing: 16){
                    HStack(spacing: 10) {
                        ForEach(0..<self.numberOfImages, id: \.self) { index in
                            Circle()
                                .frame(width: index == self.currentIndex ? 10 : 8,
                                       height: index == self.currentIndex ? 10 : 8)
                                .foregroundColor(index == self.currentIndex ?  Color.purple : Color.gray.opacity(0.25))
                                .overlay(Circle().stroke(Color.clear, lineWidth: 1))
                                .padding(.bottom, 8)
                                .animation(.spring(), value: currentIndex)
                        }
                    }
                    .frame(maxWidth: .infinity,alignment: .center)
                    .padding(.horizontal, 16)
                    
                    
                    HStack(alignment: .center, spacing: 8) {
                        if currentIndex > 0 && currentIndex != 2{
                            Group{
                                if currentIndex != 2 && currentIndex > 0 {
                                    HStack(alignment: .center, spacing: 10) {
                                        Text("Back")
                                            .font(.Fonts.styleFont(.DMSansBold, size: 16))
                                            .foregroundColor(Color.white)
                                    }
                                }
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .frame(height: 44)
                            .background(Color.clear)
                            .cornerRadius(4.0)
                            .contentShape(Rectangle())
                            .padding([.leading, .trailing], 40)
                            .onTapGesture {
                                currentIndex -= 1
                            }
                        }
                        
                        Button(action: {
                            if currentIndex != 2 {
                                currentIndex += 1
                            }else{
                                withAnimation(.default) {
                                    showOnboarding.toggle()
                                }
                            }
                        }) {
                            if currentIndex == 2 {
                                Text("Get Started!")
                                    .font(.Fonts.styleFont(.DMSansBold, size: 16))
                                    .foregroundColor(Color.white)
                                    
                            }else{
                                Text("Continue")
                                    .font(.Fonts.styleFont(.DMSansBold, size: 16))
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity ,alignment: .trailing)
                                    .background(Color.clear)
                                    .cornerRadius(8)
                                    .padding([.leading, .trailing], 40)
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 44)
                        .background(currentIndex == 2 ? Color.purple : Color.clear)
                        .cornerRadius(currentIndex == 2 ? 30 : 8)
                        .padding([.leading, .trailing], 20)
                    }
                }
                .padding(.bottom, deviceHeight < 680 ? 20 : 16)
            }
        }
    }
}
