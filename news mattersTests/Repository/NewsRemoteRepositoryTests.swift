//
//  NewsRemoteRepositoryTests.swift
//  news mattersTests
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import XCTest
@testable import news_matters

class NewsRemoteRepositoryTests: XCTestCase {

    func testGetNewsSuccessful() {
        let sut = NewsRemoteDataSource(network: MockSuccessNetworkLayer())
        let expectation = self.expectation(description: "Test Get News Successful from Remote Source")
        sut.getNews(for: "", period: 0) { (result) in
            switch result {
            case.success(let response):
                XCTAssertNotNil(response)
                XCTAssertEqual(response.status, "OK")
            case.failure(let error): XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetNewsFailure() {
        let sut = NewsRemoteDataSource(network: MockFailureNetworkLayerProtocol())
        let expectation = self.expectation(description: "Test Get News Successful from Remote Source")
        sut.getNews(for: "", period: 0) { (result) in
            switch result {
            case.success(let response): XCTAssertNil(response)
            case.failure(let error): XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}

class MockSuccessNetworkLayer: NetworkLayerProtocol {
    func perform<A>(request: any news_matters.URLRequestConvertable, completion: @escaping (Result<A, any Error>) -> Void) where A : Decodable {
        completion(.success(TestFactory.aNewsResponse as! A))
    }
}

class MockFailureNetworkLayerProtocol: NetworkLayerProtocol {
    func perform<A>(request: any news_matters.URLRequestConvertable, completion: @escaping (Result<A, any Error>) -> Void) where A : Decodable {
        completion(.failure(APIError.fakeError))
    }
}
