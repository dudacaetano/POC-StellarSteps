import SwiftUI

struct ConclusionTimerView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var task: TaskChild
    @State private var showConfetti = false
    var body: some View {
        VStack {
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
                    Text("Yay!")
                        .font(.system(size: 60, design: .rounded))
                        .fontWeight(.semibold)
                        .padding(.top, 32)
                    Text("Awesome effort! Now it's with your parents. Hang on until they validate the task!")
                        .font(.system(.body, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                    Image(.starSmile)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    Spacer()
                    Button {
                        task.isCompleted = true
                        task.isStarted = true
                        dismiss()
                    } label: {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.clear)
                            .stroke(.darkGreen)
                            .frame(height: 55)
                            .overlay{
                                Text("Back to dashboard")
                                    .font(.system(.headline, design: .rounded))
                                    .foregroundStyle(.darkGreen)
                            }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
                .foregroundStyle(.darkGreen)
                .padding(.horizontal, 16)
            }
        }
        .displayConfetti(isActive: $showConfetti)
        .toolbar {
            Image(systemName: "xmark")
                .fontWeight(.bold)
                .foregroundStyle(.clear)
        }
        .onAppear {
            showConfetti = true
        }
        .navigationBarBackButtonHidden(true)
    }
}


