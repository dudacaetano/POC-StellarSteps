import SwiftUI

struct OnboardingStep7: View {
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
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
                    
                    Image("rainbow")
                    //.resizable()
                        .ignoresSafeArea()
                        .opacity(0.9)
                        .frame(height: geometry.size.height / 2)
                        .position(x: geometry.size.width * 0.8, y: geometry.size.height * 0.22)
                    VStack(alignment: .leading){
                        
                        
                        HStack{
                            Text("Parents and chidren on an") +
                            Text(" adventure together ").bold()
                        }
                        .font(.title)
                        .foregroundColor(Color.colorPrimaryApp)
                        .frame(height: geometry.size.height * 0.1)
                        //.padding(.vertical,geometry.size.height * 0.04)

                        
                        Text("Your little one has you by their side. You'll be there to cheer them on, track their progress and get tips on how to support and motivate them! Here's how it all comes together:")
                            .font(.body)
                            .foregroundColor(Color.colorPrimaryApp)
                        
                        Spacer()
                        
                        Group {
                            let width = geometry.size.width * 0.06
                            Rectangle()
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [Color.colorRectanglePrimary, Color.colorRectangleSecondary]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .frame(width: geometry.size.width * 0.8,height: geometry.size.height * 0.65 )
                                //.position(.zero)
                                .cornerRadius(15)
                                .shadow(radius: 3)
                                .overlay(content: {
                                    VStack(alignment: .leading){
                                        HStack{
                                            Image("nao_feito")
                                                //.border(.red)
                                            Text("Task not yet started")
                                            .font(.body)
                                            .foregroundColor(Color.darkGreen)
                                        }
                                        HStack{
                                            Image("pendente_validacao")
                                                //.border(.red)
                                            Text("Awaiting validation")
                                            .font(.body)
                                            .foregroundColor(Color.darkGreen)
                                        }
                                        HStack{
                                            Image("feito")
                                                //.border(.red)
                                            Text("Task Validated")
                                            .font(.body)
                                            .foregroundColor(Color.darkGreen)
                                        }
                                        HStack{
                                            Image("bloqueado")
                                            Text("Task marked as not done")
                                            .font(.body)
                                            .foregroundColor(Color.darkGreen)
                                        }
                                        HStack{
                                            Image("cancelado")
                                            Text("Task marked as not done")
                                            .font(.body)
                                            .foregroundColor(Color.darkGreen)
                                        }
                                       
                                    }

                                    //.border(.red)
                                    //.padding(.vertical,geometry.size.height * 0.04)
                                    .frame(width: geometry.size.width * 0.9,height: geometry.size.height * 0.04 )
                                    
                                })
                        }
                        .frame(height: geometry.size.height * 0.4)
                        .padding(.horizontal, geometry.size.width * 0.05)
                        .padding(.vertical,geometry.size.height * 0.12)

                        
                        
                        NavigationLink("Continue", destination: OnboardingStep8())
                            .buttonStyle(CustomButtonStyle())
                            .frame(maxWidth: .infinity,maxHeight:.infinity, alignment: .bottom)
                        
                    }
                    .padding(.horizontal, geometry.size.width * 0.05)
//                    .padding(.vertical,geometry.size.height * 0.04)
                    
                }
                
                
            }
        }
    }
}

#Preview {
    OnboardingStep7()
        .environmentObject(OnboardingViewModel())
}

