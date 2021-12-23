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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let generalModel = GeneralViewModel()
            ContentView()
                .environmentObject(generalModel)
        }
    }
}

class AppDelegate: NSObject,  UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
    return true
    }

    
}
