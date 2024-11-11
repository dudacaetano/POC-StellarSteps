import SwiftUI

enum FontWeight {
    case medium
}

extension Font {
    static let customFont: (FontWeight, CGFloat) -> Font = { fontType, size in
        switch fontType {
        case .medium:
            Font.custom("Baby-Doll", size: size)
        }
    }
}

extension Text {
    func customFont(_ fontWeight: FontWeight? = .medium, _ size: CGFloat? = nil) -> Text {
        return self.font(.customFont(fontWeight ?? .medium, size ?? 32))
    }
}
