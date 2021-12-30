//
//  AppUploadDocsApp.swift
//  AppUploadDocs
//
//  Created by Maria Fernanda Lopez on 21/12/21.
//

import SwiftUI
import Firebase

@main
struct AppUploadDocsApp: App {
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
