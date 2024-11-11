import SwiftUI
import SwiftData

struct SetTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var totalDuration = 0
    @State private var selectedSize: Size = .medium
    @State private var value: Int = 0
    @State private var selectedMinute: Int = 5
    @State private var selectedSecond: Int = 0
    @State private var isTimerPresenting = false
    @State private var isDurationPresenting = false
    @State private var selectedDay = 7 // Valor padrão inicial
    
    @Binding var isPresenting: Bool
    @Bindable var child: Child
    var context: ModelContext
    var category: Category
    var task: TaskDTO
    
    let days = Array(1...30)
    let minutes = Array(0...59)
    let seconds = Array(0...59)
    
    var body: some View {
        VStack(spacing: 16) {
            pickerDuration()
            pickerTimer()
            Spacer()
            Button {
                // Adicionando a lógica para criar uma nova tarefa para os dias seguintes
                let currentDate = Date()
                let numberOfDays = selectedDay // Define a duração da repetição, no caso, 30 dias
                
                for dayOffset in 0..<numberOfDays {
                    let newDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
                    let newTaskChild = TaskChild(
                        id: dayOffset+1,
                        name: task.name,
                        duration: convertToSeconds(minutes: selectedMinute, seconds: selectedSecond),
                        category: category,
                        date: newDate, // Define a data da tarefa
                        child: child,
                        info: task.info,
                        childTips: task.childTips,
                        isCurrent: true
                    )
                    context.insert(newTaskChild)
                    child.tasks.append(newTaskChild)
                }
                
                try? context.save()
                isPresenting = false
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.darkGreen)
                    .frame(height: 55)
                    .overlay{
                        Text("Create new task")
                            .font(.system(.headline, design: .rounded))
                            .foregroundStyle(.white)
                    }
            }
            .padding(.bottom, 16)
        }
        .vSpacing(.top)
        .padding(.horizontal, 24)
        .toolbar{
            Button {
                isPresenting = false
            } label: {
                Image(systemName: "xmark")
                    .scaleEffect(0.8)
                    .foregroundStyle(.darkGreen)
            }
        }
        .navigationTitle(task.name)
    }
    
    @ViewBuilder
    func pickerTimer() -> some View {
        // Exibe o total em segundos
        RoundedRectangle(cornerRadius: 10)
            .fill(.clear)
            .stroke(.darkGreen, style: StrokeStyle(lineWidth: 2))
            .frame(height: 70)
            .overlay {
                HStack {
                    Text("Timer: ")
                        .font(.system(.headline, design: .rounded))
                    Spacer()
                    Button{
                        isTimerPresenting.toggle()
                    } label: {
                        Text("\(convertToSeconds(minutes: selectedMinute, seconds: selectedSecond)) seconds")
                            .font(.system(.headline, design: .rounded))
                            .foregroundStyle(.darkGreen)
                            .padding(8)
                            .background(Color.white.opacity(0.6).shadow(radius: 3))
                            .cornerRadius(10)
                    }
                    .popover(isPresented: $isTimerPresenting, attachmentAnchor: .point(.center),
                             arrowEdge: .trailing) {
                        HStack(spacing: -8) {
                            // Picker para minutos
                            Picker(selection: $selectedMinute, label: Text("Minutes")) {
                                ForEach(minutes, id: \.self) { minute in
                                    Text("\(minute) min")
                                        .tag(minute)
                                }
                            }
                            .pickerStyle(WheelPickerStyle()) // Estilo de roda
                            .frame(width: 100, height: 150)
                            .clipped()
                            
                            // Picker para segundos
                            Picker(selection: $selectedSecond, label: Text("Seconds")) {
                                ForEach(seconds, id: \.self) { second in
                                    Text("\(second) s")
                                        .tag(second)
                                }
                            }
                            .pickerStyle(WheelPickerStyle()) // Estilo de roda
                            .frame(width: 100, height: 150)
                            .clipped()
                        }
                        .presentationCompactAdaptation(.popover)
                    }
                }
                .padding(.horizontal, 16)
            }
        
    }
    
    @ViewBuilder
    func pickerDuration() -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.clear)
            .stroke(.darkGreen, style: StrokeStyle(lineWidth: 2))
            .frame(height: 70)
            .overlay {
                HStack {
                    Text("Duration: ")
                        .font(.system(.headline, design: .rounded))
                    Spacer()
                    Button{
                        isDurationPresenting.toggle()
                    } label: {
                        Text("\(selectedDay) \(selectedDay == 1 ? "day" : "days")")
                            .font(.system(.headline, design: .rounded))
                            .foregroundStyle(.darkGreen)
                            .padding(8)
                            .background(Color.white.opacity(0.6).shadow(radius: 3))
                            .cornerRadius(10)
                    }
                    .popover(isPresented: $isDurationPresenting) {
                        Picker(selection: $selectedDay, label: Text("Dia")) {
                            ForEach(days, id: \.self) { day in
                                Text("\(day) \(day == 1 ? "day" : "days")")
                                    .tag(day)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .presentationCompactAdaptation(.popover)
                    }
                }
                .padding(.horizontal, 16)
            }
    }
    
    func convertToSeconds(minutes: Int, seconds: Int) -> Int {
        return (minutes * 60) + seconds
    }
}


struct  SetTaskView_Previews: PreviewProvider {
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
