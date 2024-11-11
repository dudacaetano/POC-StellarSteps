import SwiftUI
import SwiftData

struct TaskView: View {
    @Bindable var child: Child
    @Binding var isPresenting: Bool
    var tasks: [TaskDTO]
    var category: Category
    var context: ModelContext
    
    var body: some View {
        
        if tasks.isEmpty {
            // Exibir uma mensagem ou placeholder quando não houver tarefas
            VStack {
                Text("No tasks available for \(category.rawValue)")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
                Spacer()
            }
            .navigationTitle(category.rawValue)
            .navigationBarTitleDisplayMode(.inline)
        } else {
            List {
                ForEach(tasks) { task in
                    NavigationLink {
                        SetTaskView(isPresenting: $isPresenting, child: child, context: context, category: category, task: task)
                    } label: {
                        Text(task.name)
                            .font(.headline)
                            .frame(height: 55)
                            .foregroundColor(.darkGreen)
                    }
                }
                //.listStyle(.plain)
                .listRowInsets(.init(
                    top: 16,
                    leading: 16,
                    bottom: 16,
                    trailing: 16)
                )
                .listRowSeparator(.hidden)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(category.color)
                        .stroke(category.color, style: StrokeStyle(lineWidth: 2))
                        .opacity(0.6)
                        .padding(.vertical, 8)
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
                            }
                            .padding(.horizontal, 24)
                        }
                )
            }
            .listStyle(.plain)
            .padding(.horizontal, 24)
            .scrollContentBackground(.hidden)
            .background(.clear)
            .navigationTitle(category.rawValue)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        
        let container = try! ModelContainer(for: Child.self, TaskDTO.self)
        

        let mockChild = Child(name: "Pebbles", age: 5, task: [])

        let context = ModelContext(container)
        
        context.insert(mockChild)

        let mockTask = [
            TaskDTO(
                name: "Put toys away",
                duration: 300,
                category: .routineAndOrganization,
                info: "Encourage your child to place toys back in bins or shelves after playing to keep their space tidy.",
                childTips: "Let’s put all your toys in their special places! Cars go here, and dolls go there. You’re so great at tidying up!"
            ),
            TaskDTO(
                name: "Fold laundry",
                duration: 180,
                category: .routineAndOrganization,
                info: "Help fold smaller items like washcloths, socks, or their own clothes with simple instructions.",
                childTips: "Time to fold! Start with the socks—match them up like buddies, and then we’ll tackle the shirts. You’re a folding pro!"
            ),
        ]
        
        for task in mockTask {
            context.insert(task)
        }
        
        return HomeView()
            .environment(\.modelContext, context)
    }
}
