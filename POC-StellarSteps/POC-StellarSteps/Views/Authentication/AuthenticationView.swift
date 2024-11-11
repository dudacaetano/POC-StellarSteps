import SwiftUI
import LocalAuthentication


struct AuthenticationView: View {
    @State private var useFaceID: Bool? = nil
    @State private var goToPinRegistration: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @Binding var isParent: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                if useFaceID == nil {
                    Text("Choose an authentication method")
                        .font(.title)
                        .padding()

                    Button(action: {
                        useFaceID = true
                        authenticateWithFaceID()
                    }) {
                        AnimationLockButton(title: "Use Face ID", backgroundColor: Color("light_pink"), icon1: "faceid", icon2: "checkmark.circle.fill")
                    }
                    .padding()
                    Button(action: {
                        useFaceID = false
                        goToPinRegistration = true
                        PinRegistrationView(isParent: $isParent, onAuthenticated: {
                            isParent = true
                            presentationMode.wrappedValue.dismiss()
                        })
                    }) {
                        AnimationLockButton(title: "Register PIN", backgroundColor: Color("light_green"), icon1: "lock", icon2: "lock.open")
                    }
                    .padding()

                } else if useFaceID == true {
                    Text("Trying to authenticate with Face ID...")
                } else if useFaceID == false {
                    PinRegistrationView(isParent: $isParent, onAuthenticated: {
                        isParent = true
                        presentationMode.wrappedValue.dismiss()
                    })
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Parents")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
    private func authenticateWithFaceID() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Log in using Face ID"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    if success {
                        print("Authentication successful!")
                        isParent = true
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        print("Authentication error: \(error?.localizedDescription ?? "Unknown error")")
                        goToPinRegistration = true
                        isParent = false
                        PinRegistrationView(isParent: $isParent, onAuthenticated: {
                            isParent = true
                            presentationMode.wrappedValue.dismiss()
                        })
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                goToPinRegistration = true
            }
        }
    }
}

