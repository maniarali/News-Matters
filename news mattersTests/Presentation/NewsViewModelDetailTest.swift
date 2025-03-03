//
//  NewsViewModelDetailTest.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 02/03/2025.
//

import XCTest
import Combine
@testable import news_matters

class NewsViewModelDetailTest: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    func testSomething() {
        let sut: NewsDetailViewProtocol = NewsDetailViewModel(news: TestFactory.aNews)
        sut.populateDetailData()
        let expectation = expectation(description: "Fetching data")
        sut.detailUpdate.sink(receiveValue: { value in
            expectation.fulfill()
            XCTAssertNotNil(value)
        }).store(in: &cancellables)
        sut.populateDetailData()
        
        waitForExpectations(timeout: 1)
    }
}
