
import SwiftUI

struct MedalDetailView: View {
    let medalName: String
    @State private var isAnimating = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("Sparkling Clean")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text("Showered 3 days in a row!")
                .font(.title)
                .padding()

            Text("You shined bright—great job!")
                .font(.headline)
                .padding([.leading, .trailing])

        
            Image(medalName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(isAnimating ? 5 : -5))
                .animation(Animation.linear(duration: 0.5).repeatForever(autoreverses: true), value: isAnimating)
                .onAppear {
                    isAnimating = true
                }
                .onDisappear {
                    isAnimating = false
                }
            
            Button("close") {
                dismiss()
            }
            .padding()
            .foregroundColor(Color("light_red"))
            .cornerRadius(8)
        }
        .padding()
        .navigationTitle(medalName)
    }
}

#Preview {
    MedalDetailView(medalName:"medal")
}
