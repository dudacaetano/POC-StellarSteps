import SwiftUI

struct OnboardingStep5: View {
    @State private var isAnimating = false
    @StateObject var onboardingViewModel = OnboardingViewModel()
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { geometry in
                ZStack{
                    //gradient
                    LinearGradient(
                        gradient: Gradient(colors:[Color("onboarding-primary-color"),Color("onboarding-secondary-color")]), startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                    Image("mask-star-background")
                        .resizable()
                        .ignoresSafeArea()
                        .opacity(0.5)
                        .frame(height: geometry.size.height / 2)
                        .position(x: geometry.size.width / 2, y: geometry.size.height * 0.75)
                    
                    VStack(alignment: .leading){
                        
                        Text("Parents and children on an adventure together.")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.colorPrimaryApp)
                        Spacer()
                        
                        Image("big-small-stars")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 350, height: 300)
                            .scaleEffect(isAnimating ? 1.1 : 0.9)
                        
                        Spacer()
                        
                        NavigationLink("Continue", destination: OnboardingStep6())
                            .buttonStyle(CustomButtonStyle())
                        
                    }
                    .padding(.horizontal, geometry.size.width * 0.05)

                }
                .onAppear{
                    withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
                        isAnimating = true
                    }
                }
            }
        }
        .environmentObject(onboardingViewModel)
    }
}

#Preview {
    OnboardingStep5()
        .environmentObject(OnboardingViewModel())
}

