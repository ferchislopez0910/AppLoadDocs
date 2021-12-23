//
//  GeneralViewModel.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 22/12/21.
//

import SwiftUI
import FirebaseAuth

class GeneralViewModel : ObservableObject{
    let auth = Auth.auth()

    @Published var email = ""
    @Published var password = ""
    @Published var signedIn = false
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
}




