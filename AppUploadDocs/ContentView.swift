//
//  ContentView.swift
//  AppUploadDocs
//
//  Created by Maria Fernanda Lopez on 21/12/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                ViewControllerRepresentation()
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

// ref: https://stackoverflow.com/questions/66901476/how-to-set-environmentobject-in-an-existing-storyboard-based-project
struct ViewControllerRepresentation: UIViewControllerRepresentable {
    @EnvironmentObject var bllViewModel: AppViewModel

    // Use this function to pass the @EnvironmentObject to the view controller
    // so that you can change its properties from inside the view controller scope.
    func makeUIViewController(context: Context) -> HomeViewController {
        let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
        let homeController = storyboard.instantiateViewController(identifier: "Home") { coder in
            HomeViewController(bllViewModel: bllViewModel, coder: coder)
        }
        return homeController
    }

    // Use this function to update the view controller when the @EnvironmentObject changes.
    // In this case I modify the label color based on the themeManager.
    func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {
        //uiViewController.signedIn = true
    }
}
