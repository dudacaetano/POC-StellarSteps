import SwiftUI
struct OnboardingStep2: View {
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    @State var animateStar: Bool = false
    @State var pulseEffect: Bool = false
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
                    
                    Image("rainbow")
                    //.resizable()
                        .ignoresSafeArea()
                        .opacity(0.9)
                        .frame(height: geometry.size.height / 2)
                        .position(x: geometry.size.width * 0.8, y: geometry.size.height * 0.22)
                    
                    Image("mask-star-background")
                        .resizable()
                        .ignoresSafeArea()
                        .opacity(0.5)
                        .frame(height: geometry.size.height / 2)
                        .position(x: geometry.size.width / 2, y: geometry.size.height * 0.75)
                    
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("Meet ") +
                            Text("Nova!")
                                .bold()
                        }
                        .font(.title)
                        .foregroundColor(Color.colorPrimaryApp)
                        
                        Spacer(minLength: 20)
                        
                        Text("I'll be by your little one's side everyday,cheering them on with each habit.They can achieve so much!")
                            .multilineTextAlignment(.leading)
                            .font(.body)
                            .foregroundColor(Color.colorPrimaryApp)
                        
                        Spacer(minLength: 60)
                        
                        Group{
                            let width = geometry.size.width * 0.06
                            Rectangle()
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [Color.colorRectanglePrimary, Color.colorRectangleSecondary]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .cornerRadius(15)
                                .shadow(radius: 3)
                                .overlay(content: {
                                    HStack {
                                        Text("""
                                             Make your bed for a
                                             strong star.
                                             """)
                                        .font(.body)
                                        .foregroundColor(Color.colorPrimaryApp)
                                        .padding(.trailing, geometry.size.width * 0.2)
                                        
                                        
                                        //Spacer()
                                    }
                                })
                                .overlay(alignment: .trailing) {
                                    Image("star-step1")
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: width)
                                        .offset(x:animateStar ? 0 : 200)
                                        .animation(.easeOut(duration: 1.2),value: animateStar)
                                        .scaleEffect(pulseEffect ? 1.1 : 1.0)
                                        .animation(.easeInOut(duration: 0.8), value: pulseEffect)
                                    
                                }
                                .frame(height: geometry.size.height * 0.08)
                                .padding(.horizontal, geometry.size.width * 0.09)
                            
                            Rectangle()
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [Color.colorRectanglePrimary, Color.colorRectangleSecondary]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .cornerRadius(15)
                                .shadow(radius: 3)
                                .overlay(content: {
                                    HStack{
                                        Text("""
                                             Brush teeth for a
                                             bright smile!
                                             """)
                                        .font(.body)
                                        .foregroundColor(Color.colorPrimaryApp)
                                        .padding(.leading, geometry.size.width * 0.2)
                                    }
                                })
                                .overlay(alignment: .leading){
                                    Image("star-step2")
                                        .frame(width: width)
                                        .offset(x: animateStar ? 0 : -200)
                                        .animation(.easeInOut(duration: 1.2 ), value: animateStar)
                                        .scaleEffect(pulseEffect ? 1.1 : 1.0)
                                        .animation(.easeInOut(duration: 0.9), value: pulseEffect)
                                }
                                .frame(height: geometry.size.height * 0.08)
                                .padding(.horizontal, geometry.size.width * 0.09)
                            
                            Rectangle()
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [Color.colorRectanglePrimary, Color.colorRectangleSecondary]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .cornerRadius(15)
                                .shadow(radius: 3)
                                .overlay(content:{
                                    HStack{
                                        Text("""
                                             Read daily to explore
                                             new worlds
                                             """)
                                        .font(.body)
                                        .foregroundColor(Color.colorPrimaryApp)
                                        .padding(.trailing, geometry.size.width * 0.2)
                                    }
                                })
                                .overlay(alignment: .trailing){
                                    Image("star-step3")
                                        .frame(width: width)
                                        .offset(x: animateStar ? 0 : 200)
                                        .animation(.easeOut(duration: 1.2), value: animateStar)
                                        .scaleEffect(pulseEffect ? 1.1 : 1.0)
                                        .animation(.easeOut(duration: 0.8 ), value: pulseEffect)
                                }
                                .frame(height: geometry.size.height * 0.08)
                                .padding(.horizontal, geometry.size.width * 0.09)
                            
                        }
                        .padding(.vertical, geometry.size.height * 0.06)
                        
                        NavigationLink(" Continue ", destination: OnboardingStep3())
                            .buttonStyle(CustomButtonStyle())
                            .frame(maxWidth: .infinity,maxHeight:.infinity, alignment: .bottom)
                    }
                    .padding(.horizontal, geometry.size.width * 0.05)
                    //.border(.red)
                }
            }
            .onAppear {
                animateStar = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2 ){
                    withAnimation(.easeInOut(duration: 0.8)){
                        pulseEffect = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                        pulseEffect = false
                    }
                }
                
            }
        }
    }
}



#Preview {
    OnboardingStep2()
        .environmentObject(OnboardingViewModel())
}
