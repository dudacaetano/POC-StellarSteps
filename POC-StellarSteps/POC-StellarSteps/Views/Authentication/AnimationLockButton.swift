import SwiftUI

struct AnimationLockButton: View {
    let title: String
    let backgroundColor: Color
    let icon1: String
    let icon2: String
    @State private var isLocked = true

    var body: some View {
        HStack {
            Image(systemName: isLocked ? icon1 : icon2)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
                .padding(.trailing, 5)

            Text(title)
                .font(.headline)
                .foregroundColor(.white)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.white)
        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        .onAppear {
            startAnimation()
        }
    }

    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            withAnimation {
                isLocked.toggle()
            }
        }
    }
}

