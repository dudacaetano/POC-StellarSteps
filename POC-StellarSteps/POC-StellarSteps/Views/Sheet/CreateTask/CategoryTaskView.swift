import SwiftUI
import SwiftData

struct CategoryTaskView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Bindable var child: Child
    @Binding var isPresenting: Bool
    @Query private var tasks: [TaskDTO]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Choose a new task for your child!")
                    .font(.system(.body, design: .rounded))
                    .foregroundStyle(.darkGreen)

                ForEach(Category.allCases, id: \.self) { category in
                    NavigationLink {
                        TaskView(child: child, isPresenting: $isPresenting, tasks: tasks.filter { $0.category == category }, category: category, context: context)
                            .toolbar{
                                Button {
                                    dismiss()
                                } label: {
                                    Image(systemName: "xmark")
                                        .scaleEffect(0.8)
                                        .foregroundStyle(.darkGreen)
                                }
                            }
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(category.color)
                            .stroke(category.color, style: StrokeStyle(lineWidth: 2))
                            .opacity(0.6)
                            .overlay {
                                ZStack {
                                    Image("cloud")
                                        .foregroundStyle(.white)
                                        .opacity(0.5)
                                        .frame(maxWidth: .infinity, maxHeight:.infinity, alignment: .topTrailing )
                                        .padding(.top, 32)
                                        .padding(.horizontal, 24)
                                    Image("cloud")
                                        .foregroundStyle(.white)
                                        .opacity(0.5)
                                        .frame(maxWidth: .infinity, alignment: .bottomTrailing )
                                        .padding(.horizontal, 72)
                                        .padding(.top, 80)
                                        .scaleEffect(0.5)
                                    HStack {
                                        Text(category.rawValue)
                                            .font(.headline)
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                    }
                                    .foregroundColor(.darkGreen)
                                }
                                .padding(.horizontal, 24)
                            }
                            .frame(height: 70)
                    }
                }
            }
            .vSpacing(.top)
            .padding(.horizontal, 24)
            .toolbar{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .scaleEffect(0.8)
                        .foregroundStyle(.darkGreen)
                }
            }
            .navigationTitle("Add new Task")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
