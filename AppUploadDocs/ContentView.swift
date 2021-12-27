//
//  ContentView.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 21/12/21.
//  objet generalViewModel que tien un body que ¿? 

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var generalViewModel: GeneralViewModel
    
    var body: some View {
        NavigationView {
            if generalViewModel.signedIn {
                Home()
                    .navigationTitle("Home")
                    .navigationBarHidden(false)
                    .preferredColorScheme(.light)
            }
            else {
                Login()
                    .preferredColorScheme(.dark)
                    .navigationBarHidden(true)
            }
        }
        .onAppear {
            generalViewModel.signedIn = generalViewModel.isSignedIn
        }
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}











struct contentView_Previews: PreviewProvider {

    static var previews: some View {

        ContentView()

    }

}
