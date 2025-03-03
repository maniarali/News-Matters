//
//  IntegrationTest.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 02/03/2025.
//

import XCTest
import Combine
@testable import news_matters

class NewsIntegrationTeest: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    func testSuccessFlow() {
        let remoteDataSource: NewsRemoteDataSourceProtocol = MockSuccessNewsRemoteDataSource()
        let repository: NewsRepositoryProtocol = NewsRepository(remote: remoteDataSource)
        let viewModel: NewsViewModelProtocol = NewsViewModel(repository: repository)
        let expectation = expectation(description: "Fetching data")
        viewModel.updates.sink(receiveValue: { news in
            expectation.fulfill()
        }).store(in: &cancellables)
        viewModel.fetchNews()
        
        waitForExpectations(timeout: 1)
        XCTAssertEqual(viewModel.viewData.count, 1)
    }
    
    func testFailureFlow() {
        let remoteDataSource: NewsRemoteDataSourceProtocol = MockFailureNewsRemoteDataSource()
        let repository: NewsRepositoryProtocol = NewsRepository(remote: remoteDataSource)
        let viewModel: NewsViewModelProtocol = NewsViewModel(repository: repository)
        let expectation = expectation(description: "Fetching data")
        viewModel.updates.sink(receiveValue: { news in
            expectation.fulfill()
        }).store(in: &cancellables)
        viewModel.fetchNews()
        
        waitForExpectations(timeout: 1)
        XCTAssertEqual(viewModel.viewData.count, 0)
    }
}
