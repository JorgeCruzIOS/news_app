//
//  NewlettersTests.swift
//  NewlettersTests
//
//  Created by Jorge Alfredo Cruz Acuña on 01/11/24.
//

import XCTest
@testable import Newletters
import Realm

final class ArticleVMTests: XCTestCase {

    var viewModel: ArticleVM!
    var expectation: XCTestExpectation?
    override func setUp() {
        super.setUp()
        viewModel = ArticleVM()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testSectionsCount() {
        XCTAssertEqual(viewModel.sectionsCount(), 3)
    }

    func testItemsCount() {
        viewModel.requestSectionBy(typo: 0, range: "1")
        XCTAssertEqual(viewModel.itemsCount(section: 0), 0)
    }

    func testRequestSectionSuccess() {
        expectation = self.expectation(description: "Request completed")
        viewModel.delegate = self
        viewModel.requestSectionBy(typo: 0, range: "1")
        guard let expectation = expectation else{
            XCTFail("Failure expectation ")
            return
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testRequestSectionFailure(){
        expectation = self.expectation(description: "Request completed with failure")
        viewModel.delegate = self
        viewModel.requestSectionBy(typo: 0, range: "TestFailure")
        guard let expectation = expectation else{
            XCTFail("Failure expectation ")
            return
        }
        wait(for: [expectation], timeout: 5)
    }
}

extension ArticleVMTests:ArticleVMDelegate{
    func responseItems() {
        let responseSectionList = viewModel.sectionList(section: 0)
        let responseItemBySection = viewModel.itemBySection(section: 0, item: 0)
        XCTAssertNotNil(responseSectionList)
        XCTAssertNotNil(responseItemBySection)
        expectation?.fulfill()
    }
    
    func responseFailure(message: String) {
        XCTAssertEqual(message, NetwoorkError.EmptyData.rawValue)
        expectation?.fulfill()
    }
    
    
}
