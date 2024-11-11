import SwiftUI
import SwiftData

struct HomeView: View {
    /// Task Manager Properties
    @Environment(\.modelContext) private var context
    
    @State private var showProfileChangeAlert = false
    @State private var isSheetPresented = false
    @State private var currentDate: Date = .init()
    @State private var isPresenting = false
    @State private var isParent = false
    @Query private var children: [Child]
    @Query private var parents: [Parent]
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var child: Child? {
        children.first
    }

    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                    .alert("Change Profile", isPresented: $showProfileChangeAlert) {
                        Button("Cancel", role: .cancel) { }
                        Button("Confirm") {
                            if isParent == true {
                                isSheetPresented = false
                                isParent = false
                            } else {
                                isSheetPresented = true
                            }
                        }
                    } message: {
                        Text("Do you really want to change the profile?")
                    }
                    .sheet(isPresented: $isSheetPresented) {
                        AuthenticationView(isParent: $isParent)
                            .presentationDetents([.medium])
                            .interactiveDismissDisabled(true)
                    }
                VStack(alignment: .leading, spacing: 16) {
                    HeaderView(child: child!)
                        .toolbar {
                            Button{
                                showProfileChangeAlert = true
                            } label: {
                                Image(systemName: "person.badge.key.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(.darkGreen)
                            }
                        }
                        if let child = child {
                            if let currentTask = child.tasks.first(where: { $0.isCurrent }) {
                                VStack(alignment: .leading) {
                                    Text(currentTask.name.lowercased())
                                        .customFont()
                                        .foregroundColor(.darkGreen)
                                    Text("\(currentTask.childTips)")
                                        .font(.system(.body, design: .rounded))
                                        .foregroundStyle(.darkGreen)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .background{
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(.white)
                                        }
                                }
                            } else {
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.primary, style: StrokeStyle(lineWidth: 2, dash: [10, 6]))
                                    .frame(width: 200, height: 30)
                            }
                            if child.tasks.isEmpty {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .stroke(.skyMorningLight)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                    .overlay {
                                        Button {
                                            isPresenting = true
                                        } label: {
                                            ZStack {
                                                MKImageShape(inputImage: UIImage(named: "star")!)
                                                    .stroke(.darkGreen, style: StrokeStyle(lineWidth: 2, dash: [10, 3]))
                                                    .frame(width: 50, height: 50)
                                                Image(systemName: "plus")
                                                    .foregroundStyle(.darkGreen)
                                            }
                                        }
                                    }
                                    .padding(.bottom, 24)
                            } else {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.white)
                                    ScrollView {
                                        LazyVGrid(columns: columns, spacing: 16) {
                                            ForEach(child.tasks.sorted(by: { $0.id < $1.id })) { task in
                                                StarView(task: task, currentDate: $currentDate, isParent: $isParent)
                                                    .frame(width: 100, height: 100)
                                            }
                                        }
                                        .padding()
                                    }
                                }
                            }
                        } else {
                            Text("No child data available.")
                                .font(.title)
                                .foregroundColor(.gray)
                        }
                    }
                .padding(.horizontal, 16)
                .vSpacing(.top)
            }
            .sheet(isPresented: $isPresenting) {
                if child != nil {
                    CategoryTaskView(child: child!, isPresenting: $isPresenting)
                        .presentationDetents([.fraction(0.6)])
                        .interactiveDismissDisabled(true)
                } else {
                    Text("Child not found")
                        .foregroundStyle(.darkGreen)
                        .foregroundStyle(.blue)
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                }
            }
        }
    }
    
    /// Header View
    @ViewBuilder
    func HeaderView(child: Child) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading) {
                    Text(currentDate.formatted(date: .complete, time: .omitted))
                        .font(.headline)
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                        .foregroundStyle(.darkGreen)
                    HStack(spacing: 5) {
                        Text(greetingMessage()) // Função para retornar a saudação adequada
                            .foregroundStyle(.darkGreen)
                            .foregroundStyle(.blue)
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.bold)
                        if isParent == true {
                            Text("\(parents[0].name)!")
                                .foregroundStyle(.darkGreen)
                                .foregroundStyle(.gray)
                                .font(.system(.title2, design: .rounded))
                                .fontWeight(.bold)
                            
                        } else {
                            Text("\(child.name)!")
                                .foregroundStyle(.darkGreen)
                                .foregroundStyle(.gray)
                                .font(.system(.title2, design: .rounded))
                                .fontWeight(.bold)
                        }
                    }
                }
            }
        }
        .hSpacing(.leading)
    }

    func greetingMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 6..<12:
            return "Good morning,"
        case 12..<18:
            return "Good afternoon,"
        default:
            return "Good evening,"
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let child = children[index]
            context.delete(child)
        }
        try? context.save()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        let container = try! ModelContainer(for: Child.self, TaskDTO.self)
        
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
        
        let mockChild = Child(name: "Pebbles", age: 5, task: [])
        
        let taskChild = TaskChild(id: 1, name: "Brush Teeth", duration: 240, category: .personalHygiene, date: Date(), child: mockChild, info: "PlaceHolder", childTips: "PlaceHolder", isCurrent: false, isStarted: false)
        
        let context = ModelContext(container)
        context.insert(mockChild)
        for task in mockTask {
            context.insert(task)
        }
        
        return HomeView()
            .environment(\.modelContext, context)
    }
}
