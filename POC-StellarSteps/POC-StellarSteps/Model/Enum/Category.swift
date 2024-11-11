import Foundation
import SwiftUI

enum Category: String, CaseIterable, Codable {
    case personalHygiene = "Personal Hygiene"
    case routineAndOrganization = "Routine and Organization"
    case healthAndDevelopment = "Health and Development"
    
    var color: Color {
        switch self {
        case .personalHygiene:
            return .lightPink
        case .routineAndOrganization:
            return .lightYellow
        case .healthAndDevelopment:
            return .lightGreen
        }
    }
}

