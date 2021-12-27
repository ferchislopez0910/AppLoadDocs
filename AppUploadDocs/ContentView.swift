//
//  ContentView.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 21/12/21.
//

import SwiftUI
import FirebaseAuth


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
                Login()
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
            
        }
    }
}
    



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
