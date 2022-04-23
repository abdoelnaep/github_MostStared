//
//  ReposVMTest.swift
//  github_MostStaredTests
//
//  Created by Abdullah on 23/04/2022.
//

import XCTest
@testable import github_MostStared

class ReposVMTest: XCTestCase {
    
    var viewModel: ReposVM!
    var mockApiService: MockApiService!
    override func setUp() {
        mockApiService = MockApiService()
        viewModel = .init(repoService: mockApiService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockApiService = nil
        super.tearDown()
    }
    
    func test_loadSuccess(){
        let expectaion = self.expectation(description: "repos returned successfuly from api")
        viewModel.getReps(pageNumber: "\(0)") { cells, error in
            XCTAssertNotNil(cells)
            XCTAssertNil(error)
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 6, handler: nil)
    }
    
    func test_loadFailed(){
        let expectaion = self.expectation(description: "repos failed returned from api")
        viewModel.getReps(pageNumber: "\(10000)" ) { cells, error in
            XCTAssertNil(cells)
            XCTAssertNotNil(error)
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 6, handler: nil)
    }
}
