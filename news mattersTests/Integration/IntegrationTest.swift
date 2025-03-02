//
//  IntegrationTest.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 02/03/2025.
//

import XCTest
@testable import news_matters

class NewsIntegrationTeest: XCTestCase {
    
    func testSuccessFlow() {
        let remoteDataSource: NewsRemoteDataSourceProtocol = MockSuccessNewsRemoteDataSource()
        let repository: NewsRepositoryProtocol = NewsRepository(remote: remoteDataSource)
        let viewModel: NewsViewModelProtocol = NewsViewModel(repository: repository)
        viewModel.fetchNews()
        XCTAssertEqual(viewModel.viewData.count, 1)
    }
    
    func testFailureFlow() {
        let remoteDataSource: NewsRemoteDataSourceProtocol = MockFailureNewsRemoteDataSource()
        let repository: NewsRepositoryProtocol = NewsRepository(remote: remoteDataSource)
        let viewModel: NewsViewModelProtocol = NewsViewModel(repository: repository)
        viewModel.fetchNews()
        XCTAssertEqual(viewModel.viewData.count, 0)
    }
}
