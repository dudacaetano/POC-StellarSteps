import SwiftUI

struct InitTimerView: View {
    @Bindable var task: TaskChild
    @State private var isAnimating = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.offWhite)
                    .ignoresSafeArea()
                VStack(spacing: 12) {
                    Text("Task")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.medium)
                    Text(task.name)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                    Text("Press the play button to begin the timer!")
                        .multilineTextAlignment(.center)
                        .font(.system(.body, design: .rounded))
                        .padding(.horizontal, 56)
                    Spacer()
                    Image("star_fight")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .scaleEffect(isAnimating ? 1.1 : 0.9)
                    Spacer()
                    
                    NavigationLink {
                        TimerView(task: task)
                    } label: {
                        Image(systemName: "play.circle.fill")
                            .symbolRenderingMode(.palette)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(
                                .white,
                                LinearGradient(gradient: Gradient(colors: [
                                    Color(red: 1.0, green: 0.662, blue: 0.671),
                                    Color(red: 0.769, green: 0.6, blue: 0.882),
                                    Color(red: 0.31, green: 0.851, blue: 0.792),
                                    Color(red: 0.835, green: 1.0, blue: 0.825)
                                ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .frame(width: 80, height: 80)
                    }
                    .padding(.bottom, 16)
                }
                .vSpacing(.top)
                .foregroundStyle(.darkGreen)
            }
            .onAppear{
                withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
                    isAnimating = true
                }
            }
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .fontWeight(.bold)
                        .foregroundStyle(.darkGreen)
                }
            }
        }
    }
}
