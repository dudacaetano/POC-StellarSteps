import SwiftUI

struct OnboardingStep6: View {
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
                            Text("Parent's Information!")
                                .bold()
                        }
                        .font(.title)
                        .foregroundColor(Color.colorPrimaryApp)
                        
                        Spacer()
                        
                        Text("To create a personalized experience, we'd love to know your Parent's name!")
                            .multilineTextAlignment(.leading)
                            .font(.body)
                            .foregroundColor(Color.colorPrimaryApp)
                            //.padding(.horizontal,geometry.size.height * 0.015)
                            .padding(.vertical,geometry.size.height * 0.03)
                        
                        TextField("Type Parent's name...", text: $onboardingViewModel.parentsName)
                            .padding()
                            .background(Color.colorRectanglePrimary)
                            .cornerRadius(20)
                            .padding(.horizontal,geometry.size.height * 0.015)
                            .padding(.vertical,geometry.size.height * 0.03)
                            .font(.body)
                            .foregroundColor(Color.darkGreen)
                        
                        Text("and")
                            .multilineTextAlignment(.leading)
                            .font(.body)
                            .foregroundColor(Color.colorPrimaryApp)
                            //.padding(.horizontal,geometry.size.height * 0.015)
                            .padding(.vertical,geometry.size.height * 0.03)
                        
                        Text("Enter your date of birth, it will serve as a PIN to validate the child's tasks")
                            .multilineTextAlignment(.leading)
                            .font(.body)
                            .foregroundColor(Color.colorPrimaryApp)
                            //.padding(.horizontal,geometry.size.height * 0.015)
                            .padding(.vertical,geometry.size.height * 0.03)
                        
                        TextField("How Birthday?", value: Binding<Int>(
                            get: { onboardingViewModel.parentsPin ?? 2000 },
                            set: { newValue in
                                // Validate age and set error messages
                                if newValue > 2012 {
                                    onboardingViewModel.parentsPin = nil
                                    onboardingViewModel.errorMessage = "Birth invalid."
                                } else if newValue == 0 {
                                    onboardingViewModel.parentsPin = nil
                                    onboardingViewModel.errorMessage = "Birth cannot be empty."
                                } else {
                                    onboardingViewModel.parentsPin = newValue
                                    onboardingViewModel.errorMessage = nil // Clear error if valid
                                }
                            }
                        ), formatter: NumberFormatter())
                        .padding()
                        .background(Color.colorRectanglePrimary)
                        .cornerRadius(20)
                        .padding(.horizontal, geometry.size.height * 0.015)
                        .padding(.vertical, geometry.size.height * 0.03)
                        .font(.body)
                        .foregroundColor(Color.darkGreen)
                        .keyboardType(.numberPad)
                        
                        NavigationLink("Continue", destination: OnboardingStep7())
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
    OnboardingStep6()
        .environmentObject(OnboardingViewModel())
}

