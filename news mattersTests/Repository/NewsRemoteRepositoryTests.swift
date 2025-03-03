//
//  NewsRemoteRepositoryTests.swift
//  news mattersTests
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import XCTest
import Combine
@testable import news_matters

class NewsRemoteRepositoryTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    
    func testGetNewsSuccessful() {
        let sut = NewsRemoteDataSource(network: MockSuccessNetworkLayer())
        let expectation = self.expectation(description: "Test Get News Successful from Remote Source")
        sut.getNews(for: NewsRequestModel(section: "mock-section", period: 7))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let failure):
                    XCTFail("Expected success, but got error: \(failure)")
                }
            }, receiveValue: { response in
                XCTAssertNotNil(response)
                XCTAssertEqual(response.status, "OK")
            }).store(in: &cancellables)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetNewsFailure() {
        let sut = NewsRemoteDataSource(network: MockFailureNetworkLayerProtocol())
        let expectation = self.expectation(description: "Test Get News Successful from Remote Source")
        sut.getNews(for: NewsRequestModel(section: "mock-section", period: 7))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected failure, but publisher completed successfully")
                case .failure(let failure):
                    XCTAssertNotNil(failure)
                    expectation.fulfill()
                }
            }, receiveValue: { response in
                XCTAssertNil(response)
            }).store(in: &cancellables)
        waitForExpectations(timeout: 5, handler: nil)
    }
}

class MockSuccessNetworkLayer: NetworkLayerProtocol {
    func perform<A>(request: any news_matters.URLRequestConvertable) -> AnyPublisher<A, Error> where A : Decodable {
        Just(TestFactory.aNewsResponse as! A)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

class MockFailureNetworkLayerProtocol: NetworkLayerProtocol {
    func perform<A>(request: any news_matters.URLRequestConvertable) -> AnyPublisher<A, Error> where A : Decodable {
        Fail(error: NetworkError.responseCodeError)
            .eraseToAnyPublisher()
    }
}
