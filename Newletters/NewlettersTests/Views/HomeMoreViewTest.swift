//
//  HomeMoreView.swift
//  NewlettersTests
//
//  Created by Jorge Alfredo Cruz Acuña on 02/11/24.
//

import Foundation
@testable import Newletters
import XCTest

class MockArticleVMDatasource: ArticleVMDatasource {

    var data = [ArticleSectionModel(title: "Test", identifier: "testing", image: ""),
                ArticleSectionModel(title: "Test", identifier: "testing", image: ""),
                ArticleSectionModel(title: "Test", identifier: "testing", image: "")]
    var sectionCalled = false
    
    func requestSectionBy(typo: Int, range: String) {
        sectionCalled = true
    }
    
    func sectionsCount() -> Int {
        return data.count
    }
    
    func itemsCount(section: Int) -> Int {
        return data[section].data.count
    }
    
    func sectionList(section: Int) -> Newletters.ArticleSectionModel? {
        return data[section]
    }
    
    func itemBySection(section: Int, item: Int) -> Newletters.ArticleCacheModel? {
        guard section < data.count, item < data[section].data.count else{
            return nil
        }
        return data[section].data[item]
    }
    
   
}

class HomeMoreViewTests: XCTestCase {
    var view: HomeMoreView!
    
    override func setUp() {
        super.setUp()
        view = HomeMoreView(typo: 1)
        view.loadViewIfNeeded()
    }

    override func tearDown() {
        view = nil
        super.tearDown()
    }

    func testViewDidLoadCallsBuildData() {
        view.viewDidLoad()
        XCTAssertGreaterThan(view.listNewDatasource.sectionsCount(),0)
    }
    func testReloadAction() {
        view.reloadAction()
        XCTAssertGreaterThan(view.listNewDatasource.sectionsCount(), 0)
    }

    func testTableViewDataSourceMethods() {
        let cell = view.tableView(view.listTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! HomeMoreViewCell
       XCTAssertNotNil(cell)
    }
}
