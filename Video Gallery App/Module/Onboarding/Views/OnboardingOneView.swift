import SwiftUI
import DesignSystemKit

struct OnboardingOneView: View {
    @State private var isAnimating: Bool = false
    @State private var deviceHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Image.imgOne
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

extension OnboardingOneView{
    @ViewBuilder private var OnboardingText: some View{
        
        VStack(spacing: 8){
            Text("Record Life's")
                .font(.Fonts.styleFont(.dmSansBold, size: 24))
                .foregroundColor(Color.white)
            
            Text("Moments in a Flash")
                .font(.Fonts.styleFont(.dmSansBold, size: 24))
                .foregroundColor(Color.white)
        }
    }
}