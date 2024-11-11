import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.skyMorningLight, .skyMorningDark]), startPoint: .top, endPoint: .bottom)
            .overlay {
                VStack(spacing: 24) {
                    HStack(spacing: 104) {
                        ForEach(0..<5) { index in
                            Image("cloud")
                                .foregroundStyle(.white)
                                .opacity(0.5)
                                .frame(alignment: .topLeading)
                            
                        }
                    }
                    .padding(.leading, 88)
                    HStack(spacing: 96) {
                        ForEach(0..<6) { index in
                            Image("cloud")
                                .foregroundStyle(.white)
                                .opacity(0.3)
                                .frame(alignment: .topLeading)
                        }
                    }
                    .padding(.leading, 48)
                }
                .vSpacing(.top)
                .padding(.top, 32)
            }
            .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
