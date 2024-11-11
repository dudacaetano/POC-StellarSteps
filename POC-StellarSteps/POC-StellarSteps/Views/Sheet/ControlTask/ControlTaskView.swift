import SwiftUI
import SwiftData

struct ControlTaskView: View {
    @Environment(\.modelContext) private var context
    @Bindable var task: TaskChild
    @Binding var isPresenting: Bool
    @State private var showingAlert = false
    var body: some View {
        VStack {
            Text("\(task.info)")
                .font(.system(.body, design: .rounded))
                .foregroundStyle(.darkGreen)
            Spacer()
            Button {
                task.isValidated = true
                task.isCompleted = true
                task.isStarted = true
                isPresenting = false
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.darkGreen)
                    .frame(height: 55)
                    .overlay{
                        Text("Validate activity")
                            .font(.system(.headline, design: .rounded))
                            .foregroundStyle(.white)
                    }
            }
            Button {
                task.isValidated = false
                task.isCompleted = false
                task.isStarted = false
                isPresenting = false
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.clear)
                    .stroke(.darkGreen)
                    .frame(height: 55)
                    .overlay{
                        Text("Mark as not completed")
                            .font(.system(.headline, design: .rounded))
                            .foregroundStyle(.darkGreen)
                    }
            }
            Button(role: .destructive) {
                showingAlert = true
            } label: {
                Text("Leave Progress")
                    .underline()
                    .font(.system(.headline, design: .rounded))
                    .frame(height: 55)
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Leave progress"),
                    message: Text("Are you sure you want to leave your child progress? This action is irreversible."),
                    primaryButton: .destructive(Text("Yes")) {
                        deleteProgress()
                    },
                    secondaryButton: .cancel(Text("No"))
                )
            }
        }
        .padding(.horizontal, 24)
        .vSpacing(.top)
    }
    private func deleteProgress() {
        do {
            // Crie um descriptor de busca para pegar as tarefas onde `isCurrent == true`
            let descriptor = FetchDescriptor<TaskChild>(
                predicate: #Predicate { $0.isCurrent == true }
            )
            
            // Execute a busca com o descriptor
            let tasksToDelete = try context.fetch(descriptor)
            
            // Deleta todas as tarefas encontradas
            for task in tasksToDelete {
                context.delete(task)
            }
            
            // Salve o contexto após deletar as tarefas
            try context.save()
        } catch {
            print("Erro ao buscar ou deletar as tarefas: \(error)")
        }
    }
}

struct ControlTaskView_Previews: PreviewProvider {
    static var previews: some View {
        do {
            let container = try ModelContainer(for: Parent.self, Child.self, TaskChild.self, TaskDTO.self)
            let mockTask = [
                TaskDTO(
                    name: "Put toys away",
                    duration: 300,
                    category: .routineAndOrganization,
                    info: "Encourage your child to place toys back in bins or shelves after playing to keep their space tidy.",
                    childTips: "Let’s put all your toys in their special places! Cars go aqui, e dolls go there. You’re so great at tidying up!"
                ),
                TaskDTO(
                    name: "Fold laundry",
                    duration: 180,
                    category: .routineAndOrganization,
                    info: "Help fold smaller items like washcloths, socks, or their own clothes with simple instructions.",
                    childTips: "Time to fold! Start with the socks—match them up like buddies, and then we’ll tackle the shirts. You’re a folding pro!"
                ),
            ]
            
            let mockChild = Child(name: "Pebbles", age: 5, task: [])
            
            let taskChild = TaskChild(
                id: 1,
                name: "Brush Teeth",
                duration: 240,
                category: .personalHygiene,
                date: Date(),
                child: mockChild,
                info: "PlaceHolder",
                childTips: "PlaceHolder",
                isCurrent: false,
                isStarted: false
            )
            
            let context = ModelContext(container)
            
            context.insert(mockChild)
            
            for task in mockTask {
                context.insert(task)
            }
            
            mockChild.tasks.append(taskChild)
            
            try context.save()
            
            return AnyView(ControlTaskView(task: taskChild, isPresenting: .constant(true))
                .environment(\.modelContext, context))
        } catch {
            return AnyView(Text("\(error)"))
        }
    }
}

