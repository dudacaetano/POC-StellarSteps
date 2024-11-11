import SwiftUI
import UIKit
import SwiftData

struct OnboardingStep9: View {
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool?
    @StateObject private var childViewModel = ChildViewModel()
    @StateObject private var parentsViewModel = ParentsViewModel()
    @Environment(\.modelContext) private var context

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
                    
                    
                    VStack(alignment: .leading) {
                        
                        Group{
                            Text("Time to") +
                            Text(" dive in!")
                                .bold()
                            
                        }
                        .font(.title)
                        .foregroundColor(Color.colorPrimaryApp)
                        
                        Spacer()
                        
                        Text("It's time to set up your first routine. Let's embark on this journey together!")
                            .multilineTextAlignment(.leading)
                            .font(.body)
                            .foregroundColor(Color.colorPrimaryApp)
                        
                        //Spacer()
                        
                        /*Image("big-smile-star")
                            .resizable()
                            .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.4)*/
                        
                        
                        AnimationStarRepresentable(imagePrefix: "smile", total: 5)
                            //.border(Color.red)
                            .scaleEffect(1.0)
                            .position(x: geometry.size.width * 0.45, y: geometry.size.height * 0.45)
//                            .border(Color.red)
                        
                        
                        Spacer()
                        
                        Button("Continue", action: {
                            hasSeenOnboarding = true
                        })
                        .buttonStyle(CustomButtonStyle())
                        .frame(maxWidth:.infinity, alignment: .bottom)
                    }
                    .padding(.horizontal, geometry.size.width * 0.05)
                    
                }
            }
            .onAppear{
                childViewModel.add(name: onboardingViewModel.name, age: onboardingViewModel.age ?? 0, context: context)
                parentsViewModel.add(name: onboardingViewModel.parentsName, children: [Child.init(name: onboardingViewModel.name, age: onboardingViewModel.age ?? 0)], pin: onboardingViewModel.parentsPin ?? 0, context: context)
            }
        }
    }
}

#Preview {
    OnboardingStep9()
        .environmentObject(OnboardingViewModel())
}

