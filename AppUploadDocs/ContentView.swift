//
//  ContentView.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 21/12/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                Home()
               /** VStack{
                    Text("Estas logueado")
                    Button(action: {
                        viewModel.signOut()
                    }, label: {Text("Cerrar sesión")
                            .padding(20)
                            .frame(width: 200, height: 50)
                            .foregroundColor(Color.white)
                            .background(Color(red: 152/255,
                                             green: 13/255,
                                              blue:36/255))
                            
                            .cornerRadius(25)
                            
                    })
                }*/

            }
            else {
                Login()
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
