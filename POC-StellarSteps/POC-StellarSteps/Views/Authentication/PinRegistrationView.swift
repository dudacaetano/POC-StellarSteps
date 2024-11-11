import SwiftUI
import UIKit
import SwiftData

struct PinRegistrationView: View {
    @State private var pin: String = ""
    @Environment(\.presentationMode) var presentationMode
    @Binding var isParent: Bool
    var onAuthenticated: () -> Void
    @Query private var parents: [Parent]

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Text("Please enter your birth year to make edits")
                    .font(.headline)
                    .bold()
                    .padding()
            
                HStack {
                    ForEach(0..<4) { index in
                        ZStack {
                            if index < pin.count {
                                Text(String(pin[pin.index(pin.startIndex, offsetBy: index)]))
                                    .font(.largeTitle)
                                    .foregroundColor(getColorForCharacter(at: index))
                                    .scaleEffect(1.2)
                                    .animation(.easeOut(duration: 0.3), value: pin.count)
                                    .onAppear {
                                        withAnimation(.easeOut(duration: 0.3)) {
                                            self.pin += ""
                                        }
                                    }
                                    .offset(y: -2)
                            } else {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(getColorForCharacter(at: index))
                            }
                        }
                    }
                }
                .padding()

                TextField("", text: $pin)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 0, height: 0)

                VStack {
                    ForEach(0..<3) { row in
                        HStack {
                            ForEach(0..<3) { column in
                                let character = getCharacterForRow(row, column)
                                Button(action: {
                                    if pin.count < 4 {
                                        withAnimation {
                                            pin.append(character)
                                        }
                                    }
                                    if pin.count == 4 {
                                        verifyPin(pin)
                                    }
                                }) {
                                    Text(character)
                                        .frame(width: 60, height: 30)
                                        .foregroundColor(.black)
                                        .font(.largeTitle)
                                        .cornerRadius(10)
                                }
                                .padding(5)
                            }
                        }
                    }
                    HStack {
                        Text("")
                            .frame(width: 60, height: 30)
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .cornerRadius(10)
                            
                        
                        Button(action: {
                            if pin.count < 4 {
                                pin.append("0")
                                if pin.count == 4 {
                                    verifyPin(pin)
                                }
                            }
                        }) {
                            Text("0")
                                .frame(width: 60, height: 30)
                                .foregroundColor(.black)
                                .font(.largeTitle)
                                .cornerRadius(10)
                        }.padding()
                        
                        Button(action: {
                            if !pin.isEmpty {
                                pin.removeLast()
                            }
                        }) {
                            Image(systemName: "delete.left")
                                .foregroundColor(.black)
                                .font(.largeTitle)
                                .frame(width: 40, height: 40)
                        }
                        .padding()
                    }
                }
            }
            .padding()
        }
    }

    private func getCharacterForRow(_ row: Int, _ column: Int) -> String {
        let keyboard: [[String]] = [
            ["1", "2", "3"],
            ["4", "5", "6"],
            ["7", "8", "9"]
        ]
        guard row < keyboard.count, column < keyboard[row].count else {
            return ""
        }
        return keyboard[row][column]
    }

    private func getColorForCharacter(at index: Int) -> Color {
        let colors: [Color] = [.red, .blue, .green, .orange]
        return colors[index % colors.count]
    }

    private func verifyPin(_ pin: String) {
        let correctPin = String(parents[0].pin)
        if pin == correctPin {
            isParent = true
            onAuthenticated()
        } else {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            self.pin = ""
        }
    }
}
