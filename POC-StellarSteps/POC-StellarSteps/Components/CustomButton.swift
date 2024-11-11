


import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 20))
            .fontWeight(.semibold)
            .frame(maxWidth: 350, maxHeight: 60)
            .foregroundColor(.white)
            .background(Color.colorPrimaryApp)
            .cornerRadius(6)
            
    }
}
