import SwiftUI
import SwiftData

struct OnboardingStep1: View {
    @StateObject var onboardingViewModel = OnboardingViewModel()
    @StateObject private var taskViewModel = TaskViewModel()
    @Environment(\.modelContext) private var context
    @State var moveRight = false
    
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
                        Text("Ready to build")
                            .font(.title)
                            .foregroundColor(Color.colorPrimaryApp)
                        Text("amaizing habits?")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.colorPrimaryApp)
                        
                        Group {
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
                                    
                                    Text("""
                                         Together, we'll create habits that 
                                         make your little one stronger and 
                                         ready for any challenge!
                                         """)
                                        .font(.body)
                                        .foregroundColor(Color.colorPrimaryApp)
                                        .padding(.trailing, geometry.size.width * 0.2)
                                    
                                    
                                })
                        }
                        .frame(width: geometry.size.width * 0.9,height: geometry.size.height * 0.1)
                        //.padding(.horizontal, geometry.size.width * 0.0)
                        
                        
                        AnimationStarRepresentable(imagePrefix: "step", total: 5)
                            .scaleEffect(1.2)
                            .position(x: geometry.size.width * 0.50, y: geometry.size.height * 0.3)
                        
                        NavigationLink("Let's GO!", destination: OnboardingStep2())
                            .buttonStyle(CustomButtonStyle())
                            //.frame(maxWidth: .infinity,maxHeight:.infinity, alignment: .bottom)
                        
                    }
                    .padding(.horizontal, geometry.size.width * 0.05)

                }
                .onAppear{
                    moveRight = true
                    taskViewModel.loadTasks(for: context)
                }
            }
        }
        .environmentObject(onboardingViewModel)
    }
}

#Preview {
    OnboardingStep1()
}



/*Button("Titulo", systemImage: "star") {
 
 }
 .buttonStyle(CustomButtonStyle())*/

