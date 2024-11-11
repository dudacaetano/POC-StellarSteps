import SwiftUI
import SwiftData

struct StarView: View {
    @Bindable var task: TaskChild
    @Binding var currentDate: Date
    @State private var isPresenting: Bool = false
    @Binding var isParent: Bool
    
    var body: some View {
        let calendar = Calendar.current
        
        let taskDay = calendar.startOfDay(for: task.date)
        let isCurrentDay = calendar.startOfDay(for: currentDate)
        
        let currentDay = taskDay == isCurrentDay
        let futureDay = taskDay > isCurrentDay
        let pastDay = taskDay < isCurrentDay
        
        if isParent {
            Button {
                isPresenting = true
            } label: {
                TaskState(task: task, currentDay: currentDay, futureDay: futureDay, pastDay: pastDay)
                    .sheet(isPresented: $isPresenting) {
                        NavigationStack {
                            ControlTaskView(task: task, isPresenting: $isPresenting)
                                .navigationTitle(task.name)
                                .navigationBarTitleDisplayMode(.inline)
                                .presentationDetents([.fraction(0.6)])
                        }
                    }
            }
        } else {
            if currentDay {
                Button {
                    isPresenting = true
                } label: {
                    if !task.isStarted && !task.isCompleted {
                        TaskState(task: task, currentDay: currentDay, futureDay: futureDay, pastDay: pastDay)
                            .fullScreenCover(isPresented: $isPresenting) {
                                InitTimerView(task: task)
                            }
                    } else if task.isStarted && task.isCompleted && !task.isValidated {
                        TaskState(task: task, currentDay: currentDay, futureDay: futureDay, pastDay: pastDay)
                            .alert(isPresented: $isPresenting) {
                                Alert(
                                    title: Text("Pending Validation"),
                                    message: Text("Tell your parents to validate the task"),
                                    dismissButton: .default(Text("Close")))
                            }
                    } else {
                        TaskState(task: task, currentDay: currentDay, futureDay: futureDay, pastDay: pastDay)
                            .disabled(true)
                    }
                }
            } else {
                TaskState(task: task, currentDay: currentDay, futureDay: futureDay, pastDay: pastDay)
                    .disabled(true)
            }
        }
    }
    
    @ViewBuilder
    func TaskState(task: TaskChild, currentDay: Bool, futureDay: Bool, pastDay: Bool) -> some View {
        VStack(spacing: 4) {
            // Condição 1: "feito"
            if task.isCompleted && task.isValidated && task.isStarted {
                Image(.feito)
                
                // Condição 2: "pendente_validacao"
            } else if task.isCompleted && !task.isValidated && task.isStarted {
                Image(.pendenteValidacao)
                
                // Condição 3: "cancelado" (se for o dia atual ou um dia anterior e a tarefa não foi concluída)
            } else if pastDay && !task.isCompleted && !task.isValidated {
                Image(.cancelado)
                
                // Condição 4: "não feito" (somente se for o dia atual e nada foi iniciado)
            } else if currentDay && !task.isCompleted && !task.isValidated && !task.isStarted {
                Image(.naoFeito)
                
                // Condição 5: "bloqueado" (para dias futuros, se a tarefa não foi iniciada)
            } else if futureDay && !task.isCompleted && !task.isValidated && !task.isStarted {
                Image(.bloqueado)
            }
            
            Text("Day \(task.id)")
                .font(.system(.footnote, design: .rounded))
                .fontWeight(.medium)
                .foregroundStyle(.darkGreen)
        }
    }
    
    func isSameDate(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}

struct StarView_Previews: PreviewProvider {
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
            return AnyView(StarView(task: taskChild, currentDate: .constant(.now), isParent: .constant(false))
                .environment(\.modelContext, context))
        } catch {
            return AnyView(Text("\(error)"))
        }
    }
}

