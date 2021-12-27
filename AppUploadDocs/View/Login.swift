//
//  Login.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 26/12/21.
//

import SwiftUI
import LocalAuthentication

struct Login: View {
    @State private var email = ""
    @State private var pass = ""
    @EnvironmentObject var viewModel: AppViewModel
       
    @State private var isTouchIdValid: Bool = false
    
        var body: some View {
                VStack {
                    Image("sophosIMG")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                    VStack{
                        TextField("Ingresa tu email", text: $email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                        SecureField("password", text: $pass)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                guard !email.isEmpty, !pass.isEmpty else{
                                    return
                                }
                                viewModel.signIn(email: email, password: pass)
                                }, label: {
                                    Text("Login")
                                        .foregroundColor(Color.white)
                                        .frame(width: 200, height: 50)
                                        .cornerRadius(8)
                                        .background(Color.red) //(red: 0.596, green: 0.051, blue: 0.141, opacity: 0.0))
                                    
                                })
                                .opacity(email != "" && password != "" ? 1 : 0.5)
                                .disabled(email != "" && password != "" ? false : true)
                            Spacer()

                            TouchIDButton(isValid: $isTouchIdValid)
                        }
                        NavigationLink("Crear cuenta", destination: CreateAccount())
                                .padding()
                        }
                        .padding()
                    
                        Spacer()
                }
                .navigationTitle("Login")
        }
    //TODO: pending to created errors
}


