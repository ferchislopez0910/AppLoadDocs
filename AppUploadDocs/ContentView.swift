//
//  ContentView.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 21/12/21.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject{
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool{
        return auth.currentUser != nil
        }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email,
                    password: password){ [weak self] result, error in
            guard result != nil, error == nil else {
                return
                }
            DispatchQueue.main.async {
                //Success
                self?.signedIn = true
            }
            
        }
    }
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            DispatchQueue.main.async {
                //Success
                self?.signedIn = true
            }
            
        }
        
    }
    func signOut(){
        try? auth.signOut()
        
        self.signedIn = false
    }
}

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    //colorPrimary: #980d24
    
    var body: some View {
        NavigationView{
            if viewModel.signedIn{
                VStack{
                    Text("You are signed in")
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("Sing Out")
                            .frame(width: 200, height: 50)
                            .background(Color.red) //(red: 0.596, green: 0.051, blue: 0.141, opacity: 0.0))
                            .foregroundColor(Color.gray)
                            .padding()
                    })
                }
            }
            else {
                SignInView()
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
            
        }
    }
}
    
struct SignInView: View {
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
                            viewModel.signIn(email: email, password: pass)
                            }, label: {
                                Text("Sing In")
                                    .foregroundColor(Color.white)
                                    .frame(width: 200, height: 50)
                                    .cornerRadius(8)
                                    .background(Color.red) //(red: 0.596, green: 0.051, blue: 0.141, opacity: 0.0))
                            })
                            NavigationLink("Created Account", destination: SignUpView())
                                .padding()
                        }
                        .padding()
                    
                        Spacer()
                }
                .navigationTitle("Login")
        }
    //TODO: pending to created errors
}


struct SignUpView: View {
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
