//
//  TouchIDButton.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 26/12/21.
//

import SwiftUI
import LocalAuthentication

struct TouchIDButton: View {
    
    @Binding var isValid: Bool
    var reason: String = "TouchId authentication needed!"
    
    var body: some View {
        Button(action: verify, label: {
            Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                .font(.title)
                .foregroundColor(.black)
                .padding()
                .background(Color("green"))
                .clipShape(Circle())
        })
    }
    
    private func verify() {
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: self.reason) { (success, error) in
                
                DispatchQueue.main.async {
                    self.isValid = success
                }
            }
            
        }
    }
}

struct TouchIDButton_Previews: PreviewProvider {
    static var previews: some View {
        TouchIDButton(isValid: .constant(true))
    }
}
