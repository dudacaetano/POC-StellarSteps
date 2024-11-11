import SwiftUI
import Combine
import CoreMotion

struct TimerView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var task: TaskChild
    @State private var counter: Int = 0
    @State private var isPaused: Bool = false
    @State private var showAlert: Bool = false
    @State private var navigateToConclusion = false
    
    private var countTo: Int {
        return task.duration
    }
    
    @State private var timer: AnyCancellable?
    @StateObject private var motionManager = MotionManager()
    
    var body: some View {
        VStack {
            ZStack {
                Color(.offWhite)
                    .ignoresSafeArea()
                ForEach(motionManager.stars.indices, id: \.self) { index in
                    Image("star_body")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .position(motionManager.stars[index])
                        .animation(.easeInOut(duration: 0.1), value: motionManager.stars[index])
                }
                VStack(spacing: 12) {
                    Text("Task")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.medium)
                    Text(task.name)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                    Text(counterToMinutes())
                        .font(.system(size: 60, design: .rounded))
                        .fontWeight(.semibold)
                        .padding(32)
                    Spacer()
                    ZStack {
                        Button {
                            showAlert = true
                        } label: {
                            Image(systemName: completed() ? "checkmark.circle.fill" : (isPaused ? "stop.circle.fill" : "pause.circle.fill"))
                                .resizable()
                                .contentTransition(.symbolEffect(.replace))
                                .symbolRenderingMode(.palette)
                                .frame(width: 75, height: 75)
                                .foregroundStyle(
                                    .white,
                                    LinearGradient(gradient: Gradient(colors: [
                                        Color(red: 1.0, green: 0.662, blue: 0.671),
                                        Color(red: 0.769, green: 0.6, blue: 0.882),
                                        Color(red: 0.31, green: 0.851, blue: 0.792),
                                        Color(red: 0.835, green: 1.0, blue: 0.825)
                                    ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                        }
                        .offset(x: isPaused ? 85 : 0)
                        if completed() {
                            NavigationLink(destination: ConclusionTimerView(task: task)) {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .contentTransition(.symbolEffect(.replace))
                                    .symbolRenderingMode(.palette)
                                    .frame(width: 75, height: 75)
                                    .foregroundStyle(
                                        .white,
                                        LinearGradient(gradient: Gradient(colors: [
                                            Color(red: 1.0, green: 0.662, blue: 0.671),
                                            Color(red: 0.769, green: 0.6, blue: 0.882),
                                            Color(red: 0.31, green: 0.851, blue: 0.792),
                                            Color(red: 0.835, green: 1.0, blue: 0.825)
                                        ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                            }
                        } else {
                            Button {
                                togglePauseResume()
                            } label: {
                                Image(systemName: isPaused ? "play.circle.fill" : "pause.circle.fill")
                                    .resizable()
                                    .contentTransition(.symbolEffect(.replace))
                                    .symbolRenderingMode(.palette)
                                    .frame(width: 75, height: 75)
                                    .foregroundStyle(
                                        .white,
                                        LinearGradient(gradient: Gradient(colors: [
                                            Color(red: 1.0, green: 0.662, blue: 0.671),
                                            Color(red: 0.769, green: 0.6, blue: 0.882),
                                            Color(red: 0.31, green: 0.851, blue: 0.792),
                                            Color(red: 0.835, green: 1.0, blue: 0.825)
                                        ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                            }
                            .offset(x: isPaused ? -85 : 0)
                        }
                    }
                    .padding(.bottom, 16)
                    .confirmationDialog("Already done your Task?", isPresented: $showAlert, titleVisibility: .visible) {
                        NavigationLink(destination: ConclusionTimerView(task: task)) {
                            Text("Yes, finish my task")
                        }
                        Button(role: .destructive) {
                            task.isStarted = false
                            task.isCompleted = false
                            task.isValidated = false
                            
                        } label: {
                            Text("No, leave it for later")
                        }
                    }
                }
                .vSpacing(.top)
            }
        }
        .onAppear {
            startTimer()// Chama a função para iniciar o timer
            motionManager.startAccelerometerUpdates()
        }
        .onDisappear {
            stopTimer()   // Para o timer ao sair da view
            motionManager.stopAccelerometerUpdates()
        }
    }
    
    func startTimer() {
        // Inicia um timer que dispara a cada segundo
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if self.counter < self.countTo {
                    self.counter += 1
                } else {
                    self.stopTimer() // Para o timer quando chegar ao limite
                }
            }
    }
    
    func togglePauseResume() {
        if isPaused {
            isPaused = false
            startTimer()
        } else {
            isPaused = true
            stopTimer()
        }
    }
    
    func stopTimer() {
        timer?.cancel() // Cancela o timer
        timer = nil
    }
    
    func completed() -> Bool {
        return progress() == 1
    }
    
    func progress() -> CGFloat {
        return (CGFloat(counter) / CGFloat(countTo))
    }
    
    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
        
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}

final class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    
    
    @Published var stars: [CGPoint] = []
    
    private let sensitivity: CGFloat = 50.0
    private let starCount = 1
    private let minimumDistance: CGFloat = 50.0
    
    init() {
        setupStars()
    }
    
    func setupStars() {
        var newStars: [CGPoint] = []
        
        let randomX = CGFloat.random(in: 0..<UIScreen.main.bounds.width)
        let randomY = CGFloat.random(in: 50..<UIScreen.main.bounds.height - 50)
        
        newStars.append(CGPoint(x: randomX, y: randomY))
        
        stars = newStars
    }
    
    func startAccelerometerUpdates() {
        guard motionManager.isAccelerometerAvailable else { return }
        
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: .main) { [weak self] data, error in
            guard let self = self, let data = data else { return }
            self.updateStarsPosition(with: data.acceleration)
        }
    }
    
    func stopAccelerometerUpdates() {
        motionManager.stopAccelerometerUpdates()
    }
    
    private func updateStarsPosition(with acceleration: CMAcceleration) {
        let deltaX = CGFloat(acceleration.x * sensitivity)
        let deltaY = CGFloat(-acceleration.y * sensitivity)
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        guard let index = stars.indices.first else { return }
        let newX = stars[index].x + deltaX
        let newY = stars[index].y + deltaY
        
        stars[index] = CGPoint(
            x: max(25, min(newX, screenWidth - 25)),
            y: max(50, min(newY, screenHeight - 150))
        )
    }
}

