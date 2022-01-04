//
//  CreateAccount.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 26/12/21.
//

import SwiftUI


struct CreateAccount: View {
        @State var email = ""
        @State var pass = ""
        @EnvironmentObject var viewModel: AppViewModel
        //colorPrimary: #980d24
        var body: some View {
                VStack {
                    Image("sophosIMG")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                    VStack{
                        TextField("Ingresa tu correo", text: $email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            
                        SecureField("Ingresa tu contraseña", text: $pass)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                        
                        Button(action: {
                            
                            guard !email.isEmpty, !pass.isEmpty else{
                                return
                            }
                            
                            viewModel.signUp(email: email, password: pass)
                            
                            }, label: {
                                Text("Crear cuenta")
                                    .foregroundColor(Color.white)
                                    .frame(width: 200, height: 50)
                                    .background(Color(red: 152/255,
                                                     green: 13/255,
                                                      blue:36/255))
                                    
                                    .cornerRadius(25)
                            })
                    }
                    .padding()
                    Spacer()
                }.navigationTitle("Crear cuenta")
    }
}

