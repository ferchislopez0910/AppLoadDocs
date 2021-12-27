//
//  LoginViewModel.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 22/12/21.
//

import SwiftUI
import LocalAuthentication


class LoginViewModel : ObservableObject{
    @StateObject var GeneralModel = GeneralViewModel()
    // for message - alerts..
    @Published var alert = false
    @Published var alertMsg = ""
    
    @AppStorage("stored_User") var stored_User = ""
    @AppStorage("stored_Password") var stored_Password = ""
    @AppStorage("status") var logged = false
    
    @Published var store_Info = false
    
    func signIn(email: String, password: String) {
        GeneralModel.auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            // Success
            DispatchQueue.main.async {
                self?.GeneralModel.signedIn = true
            }
        }
    }

    func signOut() {
        try? GeneralModel.auth.signOut()
        self.GeneralModel.signedIn = false
    }
    // getting biometricType
    func getBioMetricStatus()-> Bool{

        let scanner = LAContext()
        if GeneralModel.email == stored_User &&
            scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none) {
                return true
        }
        return false
    }
    func authenticateUser(){
        let scanner = LAContext()

        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Desbloquea tu \($GeneralModel.email)") {
            (status, err) in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            // setting logged status as true
            //withAnimation(.easeOut){logged = true}
        }
    }
    
    func verifyUser(){
        GeneralModel.auth.signIn(withEmail: GeneralModel.email, password: GeneralModel.password){
            (res, err) in
            if let error = err{
                self.alertMsg = error.localizedDescription
                self.alert.toggle()
                return
            }
            // Ok
            if self.stored_User == "" || self.stored_Password == ""{
                self.store_Info.toggle()
                return
            }
            // Else go to home
            withAnimation{
                self.logged = true
                self.GeneralModel.signedIn = true
            }
        }
    }
}
