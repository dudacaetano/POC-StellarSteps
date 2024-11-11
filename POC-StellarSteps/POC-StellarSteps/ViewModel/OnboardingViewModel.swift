import SwiftUI

import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var age: Int? = nil
    @Published var parentsName: String = ""
    @Published var parentsPin: Int? = nil
    @Published var errorMessage: String? = nil
}

