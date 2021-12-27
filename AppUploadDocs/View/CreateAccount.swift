//
//  CreateAccount.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 26/12/21.
//

import SwiftUI
import FirebaseAuth

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
                        TextField("Put your email", text: $email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            
                        SecureField("Put your password", text: $pass)
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
                                Text("Created Account")
                                    .foregroundColor(Color.white)
                                    .frame(width: 200, height: 50)
                                    .cornerRadius(8)
                                    .background(Color.red) //(red: 0.596, green: 0.051, blue: 0.141, opacity: 0.0))
                            })
                    }
                    .padding()
                    Spacer()
                }.navigationTitle("Created Account")
    }
}

