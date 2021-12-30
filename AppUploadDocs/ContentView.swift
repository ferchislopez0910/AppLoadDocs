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
                HomeController()
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


struct HomeController : UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<HomeController>) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "Home")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<HomeController>) {
    }
    
}
