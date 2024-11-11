import SwiftUI

struct OnboardingStep8: View {
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    var body: some View {
        NavigationStack{
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
                    
//                    Image("rainbow")
//                    //.resizable()
//                        .ignoresSafeArea()
//                        .opacity(0.9)
//                        .frame(height: geometry.size.height / 2)
//                        .position(x: geometry.size.width * 0.8, y: geometry.size.height * 0.22)
                    
                    VStack(alignment: .leading) {
                        
                        HStack{
                            Text("Check their") +
                            Text(" progress").bold() +
                            Text(" and celebrate their") +
                            Text(" achievements")
                                .bold()
                        }
                        .font(.title)
                        .foregroundColor(Color.colorPrimaryApp)
                        .frame(width: geometry.size.width / 1.5 )
                        
                        Spacer()
                        Text("Trancking habits helps you stay on top of your goals and see your progress.Every small step counts toward becoming your best self!")
                            .multilineTextAlignment(.leading)
                            .font(.body)
                            .foregroundColor(Color.colorPrimaryApp)
                        
                        Image("trofeu-star")
                            .position(x: geometry.size.width * 0.45, y: geometry.size.height * 0.3)
                        
                        
                        AnimationStarRepresentable(imagePrefix: "nuvem", total: 6)
                            .scaleEffect(1.6)
                        
                        
                        
                        
                        
                        
                        NavigationLink("Continue", destination: OnboardingStep9())
                            .buttonStyle(CustomButtonStyle())
                            .frame(maxWidth:.infinity,maxHeight:.infinity, alignment: .bottom)
                    }
                    .padding(.horizontal, geometry.size.width * 0.05)

                }
            }
            
        }
    }
}



#Preview {
    OnboardingStep8()
        .environmentObject(OnboardingViewModel())
}
