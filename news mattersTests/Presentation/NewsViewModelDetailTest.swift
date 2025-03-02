//
//  NewsViewModelDetailTest.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 02/03/2025.
//

import XCTest
@testable import news_matters

class NewsViewModelDetailTest: XCTestCase {
    
    func testSomething() {
        let view = MockNewsDetailView()
        var sut: NewsDetailViewProtocol = NewsDetailViewModel(news: TestFactory.aNews)
        sut.delegate = view
        sut.populateDetailData()
        sut.delegate?.showDetails(with: TestFactory.aNews.url)
        
        XCTAssertEqual(view.fetchUserCalled, true)
    }
}

class MockNewsDetailView: UIViewController, NewsDetailViewDelegate {
    
    var fetchUserCalled = false
    func showDetails(with detail: String) {
        fetchUserCalled = true
    }
}
