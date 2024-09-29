import SwiftUI
import DesignSystemKit

struct OnboardingTwoView: View {
    @State private var isAnimating: Bool = false
    @State private var deviceHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Image.imgTwo
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

extension OnboardingTwoView{
    @ViewBuilder private var OnboardingText: some View{
        
        VStack(spacing: 4){
            Text("Your Stories, Our")
                .font(.Fonts.styleFont(.dmSansBold, size: 24))
                .foregroundColor(Color.white)
            
            Text("Stage: Short, Sweet,")
                .font(.Fonts.styleFont(.dmSansBold, size: 24))
                .foregroundColor(Color.white)
            
            Text("and Stunning!")
                .font(.Fonts.styleFont(.dmSansBold, size: 24))
                .foregroundColor(Color.white)
        }
    }
}
