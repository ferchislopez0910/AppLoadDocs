//
//  ViewDocsControllerTests.swift
//  AppUploadDocsTests
//
//  Created by Maria Fernanda Lopez on 11/01/22.
//

import XCTest
@testable import AppUploadDocs

class ViewDocsControllerTests: XCTestCase {
    
    let email = "ferchislopez0910@gmail.com"

    var viewDocsController : ViewDocsController!
    
    override func setUpWithError() throws {
        super.setUp()
        
    }
    
    override func tearDownWithError() throws {
        viewDocsController = nil
        super.tearDown()
    }
    
    // MARK: - Test bllGetDocument List documents
    
    func testListDocumentsSucess(){
        // given
        viewDocsController = ViewDocsController()
        viewDocsController.Stored_Email = email
        
        //when
        viewDocsController.viewDidLoad()
        
        //then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
          
            guard let countListDocs = self.viewDocsController.objDocuments?.Count else {
                return
            }
            XCTAssert(countListDocs > 0)
        }
    }
    
}
