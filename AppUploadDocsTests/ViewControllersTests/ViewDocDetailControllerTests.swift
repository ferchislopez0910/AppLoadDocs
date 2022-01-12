//
//  ViewDocDetailControllerTests.swift
//  AppUploadDocsTests
//
//  Created by Maria Fernanda Lopez on 11/01/22.
//
@testable import AppUploadDocs
import XCTest

class ViewDocDetailControllerTests: XCTestCase {
    

    var viewDocDetailCtr : ViewDocDetailController!
    
    override func setUpWithError() throws {
        super.setUp()
        
    }
    
    override func tearDownWithError() throws {
        viewDocDetailCtr = nil
        super.tearDown()
    }
    
    // MARK: - Test bllGetImage - logica de negocio para obtener las imagenes
    func testDownloadImageSucces() throws {
        // given
        let idRegistro = "becca8e9-02b7-4ed3-b6fe-af53ac0d031d"
        viewDocDetailCtr = ViewDocDetailController()
        viewDocDetailCtr.idRegistro = idRegistro
        viewDocDetailCtr.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
          
            guard let countImages = self.viewDocDetailCtr.objImage?.Count else {
                return
            }
            XCTAssert(countImages > 0)

        
        }
    }
    
    func testDownloadImageFailed() throws {
        // given
        let idRegistro = "000000"
        viewDocDetailCtr = ViewDocDetailController()
        viewDocDetailCtr.idRegistro = idRegistro
        viewDocDetailCtr.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
          
            guard let countImages = self.viewDocDetailCtr.objImage?.Count else {
                return
            }
            XCTAssert(countImages == 0)
        }
    }

}
