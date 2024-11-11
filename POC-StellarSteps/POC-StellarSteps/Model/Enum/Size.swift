import Foundation

enum Size: String, CaseIterable, Codable {
    case small
    case medium
    case large
    
    var dimension: CGFloat {
        switch self {
        case .small:
            return 50
        case .medium:
            return 75
        case .large:
            return 100
        }
    }
}
