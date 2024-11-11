import SwiftUI

extension Color {
    func darker(by percentage: CGFloat = 0.2) -> Color {
        // Converter para UIColor para acessar os componentes RGB
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        // Obter os componentes RGB
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Diminuir os componentes RGB pela porcentagem fornecida
        return Color(
            red: max(red - percentage, 0.0),
            green: max(green - percentage, 0.0),
            blue: max(blue - percentage, 0.0),
            opacity: Double(alpha)
        )
    }
}
