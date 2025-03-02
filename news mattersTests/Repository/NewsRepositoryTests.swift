//
//  NewsRepositoryTest.swift
//  news mattersTests
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import XCTest
@testable import news_matters

class NewsRepositoryTest: XCTestCase {

    func testGetNewsSuccessful() {
        let sut = NewsRepository(remote: MockSuccessNewsRemoteDataSource())
        let expectation = self.expectation(description: "Test Get News Successful from Remote Source")
        sut.getNews { (result) in
            switch result {
            case.success(let response): XCTAssertNotNil(response)
            case.failure(let error): XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetNewsFailure() {
        let sut = NewsRepository(remote: MockFailureNewsRemoteDataSource())
        let expectation = self.expectation(description: "Test Get News Successful from Remote Source")
        sut.getNews { (result) in
            switch result {
            case.success(let response): XCTAssertNil(response)
            case.failure(let error): XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}

class MockSuccessNewsRemoteDataSource: NewsRemoteDataSourceProtocol {
    func getNews(for request: news_matters.NewsRequestModel, completion: @escaping (Result<NewsResponseModel, Error>) -> Void) {
        completion(.success(TestFactory.aNewsResponse))
    }
}

class MockFailureNewsRemoteDataSource: NewsRemoteDataSourceProtocol {
    func getNews(for request: news_matters.NewsRequestModel, completion: @escaping (Result<NewsResponseModel, Error>) -> Void) {
        completion(.failure(APIError.fakeError))
    }
}
