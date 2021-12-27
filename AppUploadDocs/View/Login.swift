//
//  Login.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 22/12/21.
//

import SwiftUI
import LocalAuthentication

struct Login: View {
    
    @StateObject var loginModel = LoginViewModel()
    @StateObject var generalModel = GeneralViewModel()
    
    var body: some View {
        VStack {
            Image("sophosIMG")
                .resizable()
                .scaledToFit()
                .frame(width:200,height: 200)
            
            VStack {
                // input email
                TextField("Correo Electrónico", text: $generalModel.email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                // input password
                SecureField("Contraseña", text: $generalModel.password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                //button
                Button(action:{
                    guard !generalModel.email.isEmpty, !generalModel.password.isEmpty else {
                        return
                    }
                    loginModel.verifyUser()
                    //loginModel.signIn(email: generalModel.email, password: generalModel.password)
                }, label: {
                    
                    Text("Iniciar Sesión")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color.red)
                        .cornerRadius(8)
                    
                })
                    .opacity(generalModel.email != "" && generalModel.password != "" ? 1 : 0.5)
                    .disabled(generalModel.email != "" && generalModel.password != "" ? false : true)
                    .alert(isPresented: $loginModel.alert, content: {
                        Alert(title: Text("Error"), message: Text(loginModel.alertMsg), dismissButton: .destructive(Text("Ok")))
                    } )
                //button biometric faceID
                if loginModel.getBioMetricStatus(){
                    Button(action: loginModel.authenticateUser
                            , label: {
                        Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color("red"))
                            .clipShape(Circle())
                    })
                }
                
                //link
                NavigationLink("Crear cuenta", destination: CreatedAccount())
                    .padding()
                
            }
            .padding()
        }
        .navigationTitle("Login")
        
        .alert(isPresented: $loginModel.alert, content: {
            Alert(title: Text("Mensaje"), message: Text("¿Quieres guardar  usuario y contraseña?"), primaryButton: .default(Text("Aceptar"), action: {
                loginModel.stored_User = generalModel.email
                loginModel.stored_Password = generalModel.password
            }), secondaryButton:  .cancel({
                //redirection go to home
                withAnimation{
                    loginModel.logged = true
                    self.generalModel.signedIn = true
                }
            }))
        })
    }
}
