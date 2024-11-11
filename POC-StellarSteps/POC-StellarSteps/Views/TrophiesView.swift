import SwiftUI

struct TrophiesView: View {
    let medals: [String] = ["medal-gold", "medal-prata", "medal-bronze", "medal", "medal", "medal", "medal", "medal","medal", "medal", "medal", "medal", "medal", "medal"]
    
    @State private var selectedMedal: String?
    @State private var isSheetPresented = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.skyMorningLight, .skyMorningDark]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    
                    VStack {
                        Image("trofeu-star")
                            .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.2)
                        
                        Image("mountains")
                            .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.23)
                            .overlay(alignment: .trailing) {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.8))
                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.6)
                                    .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.16)
                                    .overlay {
                                        ScrollView {
                                
                                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                                                ForEach(medals, id: \.self) { medal in
                                                    Button(action: {
                                                      selectedMedal = medal
                                                      isSheetPresented = true
                                                    }) {
                                                        Image(medal)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 80, height: 80)
                                                            .cornerRadius(8)
                                                    }
                                                    
                                                }
                                                .sheet(isPresented: $isSheetPresented) {
                                                    if let medal = selectedMedal {
                                                        MedalDetailView(medalName: medal )
                                                            .font(.headline)
                                                            .presentationDetents([.medium])
                                                                        
                                                    }
                                                }
                                            }
                                            
                                        }
                                        .position(x: geometry.size.width * 0.45, y: geometry.size.height * 0.16)
                                        .padding()
                                        
                                    }
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    TrophiesView()
}
