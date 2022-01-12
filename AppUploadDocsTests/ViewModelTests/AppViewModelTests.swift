//
//  AppViewModelTests.swift
//  AppUploadDocsTests
//
//  Created by Maria Fernanda Lopez on 11/01/22.
//

import XCTest
import SwiftUI
import Foundation

@testable import AppUploadDocs

class AppViewModelTests: XCTestCase {
    
    let userName = "ferchislopez0910@gmail.com"
    let password = "A6S3k5hZhWyPzcX2"
    let password_err = "123"
    var appViewModel : AppViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        appViewModel = AppViewModel()
    }
    
    override func tearDownWithError() throws {
        appViewModel = nil
        super.tearDown()
    }
    
    func testEmailCorrectToLogin() throws {
        // given
        let testEmail = "example@example.com"
        
        //when then
        XCTAssertTrue(appViewModel.textFieldValidatorEmail(testEmail))
    }

    func testEmailIncorrectToLogin() throws {
        // given
        let testEmail = "exampleexample.com"
        
        //when then
        XCTAssertFalse(appViewModel.textFieldValidatorEmail(testEmail))
    }
    
    
    // MARK: - Test Login
    func testAuthenticateSucess(){
        // given - login
        appViewModel.email = userName
        appViewModel.password = password
        appViewModel.verifyUser()
        // dalay -- wait login
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print(self.appViewModel.signedIn)
        // when then
            XCTAssertTrue(self.appViewModel.signedIn)
        }

    }
    
    // MARK: - Test Login
    func testAuthenticateFailed(){
        // given - login
        appViewModel.email = userName
        appViewModel.password = password_err
        appViewModel.verifyUser()
        // dalay -- wait login
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print(self.appViewModel.signedIn)
        // when then
            XCTAssertTrue(self.appViewModel.signedIn)
        }

    }
    
    // MARK: - Test Logout
    func testLogoutSucess(){
        // given - login
        appViewModel.email = userName
        appViewModel.password = password
        appViewModel.verifyUser()
        // dalay -- wait login
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        }
        // cerrar sesion
        appViewModel.signOut()
        // delay - wait logout
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print(self.appViewModel.signedIn)
        // when then
            XCTAssertFalse(self.appViewModel.signedIn)
        }
    }
   
    

    

    
}
