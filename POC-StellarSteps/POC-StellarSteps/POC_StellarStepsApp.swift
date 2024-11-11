
import SwiftUI
import SwiftData


@main
struct NovaApp: App {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false

    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                ContentView()
            } else {
                SplashScreenView()
            }
        }
        .modelContainer(for: [Parent.self, Child.self, TaskChild.self, TaskDTO.self])
    }
}


//
//struct POC_StellarStepsApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
