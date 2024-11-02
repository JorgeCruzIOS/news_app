//
//  ImageArticleVMTest.swift
//  NewlettersTests
//
//  Created by Jorge Alfredo Cruz Acuña on 01/11/24.
//

import XCTest
@testable import Newletters

final class ImageArticleVMTest: XCTestCase {

    var viewModel: ImageArticleVM!
    var expectation: XCTestExpectation?
    override func setUp() {
        super.setUp()
        viewModel = ImageArticleVM()
        viewModel.delegate = self
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testRequestImageBySuccess(){
        let testUrl = "https://static01.nyt.com/images/2024/10/31/multimedia/31xp-flight-fwcl-copy/31xp-flight-fwcl-mediumThreeByTwo210.jpg"
        expectation = self.expectation(description: "ImageArticleVMTest completed")
        viewModel.requestImageBy(url: testUrl)
        guard let expectation = expectation else{
            XCTFail("Failure expectation ")
            return
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testRequestImageByFailure(){
        let testUrl = "https://static01.nyt.com/images/2024/10/31/multimedia/31xp-flight-fwcl-copy/failure.jpg"
        expectation = self.expectation(description: "ImageArticleVMTest completed with failure")
        viewModel.requestImageBy(url: testUrl)
        guard let expectation = expectation else{
            XCTFail("Failure expectation ")
            return
        }
        wait(for: [expectation], timeout: 5)
    }
}

extension ImageArticleVMTest:ImageArticleVMDelegate{
    func responseFailure() {
        expectation?.fulfill()
    }
    
    func responseImage(data: Data) {
        XCTAssertNotNil(data)
        expectation?.fulfill()
    }
}
