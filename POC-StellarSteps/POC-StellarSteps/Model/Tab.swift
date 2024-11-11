import SwiftUI

enum Tab: String, CaseIterable {
    case star = "Star"
    case throphies = "Throphies"
    
    var systemImage: String {
        switch self {
        case .star: return "star.fill"
        case .throphies: return "trophy.fill"
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
    
}
