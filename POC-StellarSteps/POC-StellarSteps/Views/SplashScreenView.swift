import SwiftUI

struct SplashScreenView: View {
    
    @State private var starsVisible: Bool = true
    @State private var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        
        if isActive {
            SplashScreen() // Substitua pela sua próxima view após o SplashScreen
        } else {
            ZStack {
                // Fundo com gradiente
                LinearGradient(gradient: Gradient(colors: [Color(Color.darkBlue), Color(Color.lightBlue)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                // Animação das estrelas
                starsOverlay()
            }
            .onAppear {
                // Inicia a animação das estrelas
                withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                    starsVisible.toggle()
                }
                
                // Timer para transitar para a próxima tela após um tempo
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.isActive = true
                }
            }
        }
    }
    
    // Função para criar as estrelas animadas
    func starsOverlay() -> some View {
        ZStack {
            ForEach(0..<30) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.yellow)
                    .opacity(starsVisible ? 1 : 0.2)
                    .scaleEffect(starsVisible ? 1.0 : 0.5)
                    .position(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                              y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: starsVisible)
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
