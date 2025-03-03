//
//  NewsRepositoryTest.swift
//  news mattersTests
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import XCTest
import Combine
@testable import news_matters

class NewsRepositoryTest: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    func testGetNewsSuccessful() {
        let sut = NewsRepository(remote: MockSuccessNewsRemoteDataSource())
        let expectation = self.expectation(description: "Test Get News Successful from Remote Source")
        sut.getNews()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let failure):
                    XCTFail("Expected success, but got error: \(failure)")
                }
            } receiveValue: { news in
                XCTAssertNotNil(news)
                XCTAssertEqual(news.count, 1)
            }.store(in: &cancellables)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetNewsFailure() {
        let sut = NewsRepository(remote: MockFailureNewsRemoteDataSource())
        let expectation = self.expectation(description: "Test Get News Successful from Remote Source")
        sut.getNews()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected failure, but publisher completed successfully")
                case .failure(let failure):
                    XCTAssertNotNil(failure)
                    expectation.fulfill()
                }
            }, receiveValue: { news in
                XCTAssertNil(news)
            }).store(in: &cancellables)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

class MockSuccessNewsRemoteDataSource: NewsRemoteDataSourceProtocol {
    func getNews(for request: NewsRequestModel) -> AnyPublisher<NewsResponseModel, any Error> {
        Just(TestFactory.aNewsResponse)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

class MockFailureNewsRemoteDataSource: NewsRemoteDataSourceProtocol {
    func getNews(for request: NewsRequestModel) -> AnyPublisher<NewsResponseModel, any Error> {
        Fail(error: APIError.fakeError)
            .eraseToAnyPublisher()
    }
}
