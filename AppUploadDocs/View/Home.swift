//
//  Home.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 23/12/21.
//  home tienen
// VSTACK ¿?

import SwiftUI

struct Home: View {
    @StateObject var loginModel = LoginViewModel()
    var body: some View {
        
        
        VStack{
            Text("Estas logueado")
                .navigationTitle("Home")
                .navigationBarHidden(false)
                .preferredColorScheme(.light)

            Button(action: {
                loginModel.signOut()
            }, label: {Text("Cerrar sesión")
                    .frame(width: 200, height: 50)
                    .background(Color.green)
                    .foregroundColor(Color.red)
                    .padding()
            })
        }
    }
}

