import SwiftUI

struct SplashScreen: View {
    
    @State private var isActive: Bool = false
    @State private var size: CGFloat = 0.8
    @State private var opacity:Double = 0.5
    
    var body: some View {
        
        if isActive {
            OnboardingStep1()
        } else {
            ZStack {
                GeometryReader { geometry in
                    // Fundo com gradiente
                    LinearGradient(
                        gradient: Gradient(colors:[Color(Color.darkBlue),Color(Color.lightBlue)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()

                    Image("mask-star-background")
                        .resizable()
                        .ignoresSafeArea()
                        .opacity(0.1)
                        .frame(height: geometry.size.height / 2)
                        .position(x: geometry.size.width / 2, y: geometry.size.height * 0.75)
                    Image("logo-nova")
                        .scaleEffect(size) // Escala para o efeito de aproximação
                        .opacity(opacity) // Controla a opacidade
                        .position(x: geometry.size.width / 2, y: geometry.size.height * 0.5)
                }
            }
            .onAppear {
                withAnimation(.easeIn(duration: 1.2)) {
                    self.size = 1.0 // Animação de aumento do logo
                    self.opacity = 1.0 // Animação de suavização da opacidade
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeOut(duration: 1)) {
                        self.size = 3.0 // Expande ainda mais para parecer que sai da tela
                        self.opacity = 0.0 // Diminui a opacidade até desaparecer
                    }
                }
                
                // Timer para transitar para a tela principal após 2 segundos
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.isActive = true
                }
            }
        }
    }
}
#Preview {
    SplashScreen()}
