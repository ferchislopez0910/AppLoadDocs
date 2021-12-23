//
//  Home.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 23/12/21.
//

import SwiftUI

struct Home: View {
    var body: some View {
        @StateObject var loginModel = LoginViewModel()
        
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

