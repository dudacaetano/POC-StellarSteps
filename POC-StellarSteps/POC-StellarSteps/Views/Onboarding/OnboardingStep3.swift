import SwiftUI

struct OnboardingStep3: View {
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
                    
                    Image("rainbow")
                    //.resizable()
                        .ignoresSafeArea()
                        .opacity(0.9)
                        .frame(height: geometry.size.height / 2)
                        .position(x: geometry.size.width * 0.8, y: geometry.size.height * 0.22)
                       
                    
                    VStack(alignment: .leading) {
                        
                        VStack(alignment: .leading) {
                            Text("But the shinning star is")
                            Text("your little one!")
                                .bold()
                        }
                        .font(.title)
                        .foregroundColor(Color.colorPrimaryApp)
                        
                        Spacer()
                        
                        Text("To create a personalized experience, we'd love to know your chlid's name!")
                            .multilineTextAlignment(.leading)
                            .font(.body)
                            .foregroundColor(Color.colorPrimaryApp)
                            //.padding(.horizontal,geometry.size.height * 0.015)
                            .padding(.vertical,geometry.size.height * 0.03)
                        
                        TextField("Type your child's name...", text: $onboardingViewModel.name)
                            .padding()
                            .background(Color.colorRectanglePrimary)
                            .cornerRadius(20)
                            .padding(.horizontal,geometry.size.height * 0.015)
                            .padding(.vertical,geometry.size.height * 0.03)
                            .font(.body)
                            .foregroundColor(Color.darkGreen)
                        
                        
                        NavigationLink("Continue", destination: OnboardingStep4())
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
    OnboardingStep3()
        .environmentObject(OnboardingViewModel())
}
