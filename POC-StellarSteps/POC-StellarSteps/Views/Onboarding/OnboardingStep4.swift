import SwiftUI

struct OnboardingStep4: View {
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
                        
                        HStack{
                            Text("Tailored").bold() +
                            Text(" and") +
                            Text(" age-appropriate").bold() +
                            Text(" tasks")
                        }
                        .font(.title)
                        .foregroundColor(Color.colorPrimaryApp)
                        
                        Spacer()
                        
                        Text("To make it just right for your child, we need to know their age!That way we can prvide a list of fun and age-appropriate tasks and habits.")
                            .multilineTextAlignment(.leading)
                            .font(.body)
                            .foregroundColor(Color.colorPrimaryApp)
                            .padding(.vertical,geometry.size.height * 0.03)
                        
                        
                        TextField("How old is your little star?", value: Binding<Int>(
                            get: { onboardingViewModel.age ?? 5 },
                            set: { newValue in
                                // Validate age and set error messages
                                if newValue < 4 {
                                    onboardingViewModel.age = nil
                                    onboardingViewModel.errorMessage = "Age must be between 4 and 12."
                                } else if newValue > 12 {
                                    onboardingViewModel.age = nil
                                    onboardingViewModel.errorMessage = "Age must be between 4 and 12."
                                } else if newValue == 0 {
                                    onboardingViewModel.age = nil
                                    onboardingViewModel.errorMessage = "Age cannot be empty."
                                } else {
                                    onboardingViewModel.age = newValue
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
                        
                        // Show error message if exists
                        if let errorMessage = onboardingViewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red) // Color for error message
                                .font(.caption)
                                .padding(.top, 5)
                        }

                        
                        NavigationLink("Continue", destination: OnboardingStep5())
                            .buttonStyle(CustomButtonStyle())
                            .frame(maxWidth:.infinity,maxHeight:.infinity, alignment: .bottom)
                            .disabled(onboardingViewModel.age == nil || onboardingViewModel.age! < 4 || onboardingViewModel.age! > 12)
                    }
                    .padding(.horizontal, geometry.size.width * 0.05)

                }
            }
            
        }
    }
}

#Preview {
    OnboardingStep4()
        .environmentObject(OnboardingViewModel())
}
