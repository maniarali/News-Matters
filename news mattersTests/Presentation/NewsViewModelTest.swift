//
//  NewsViewModelTest.swift
//  news mattersTests
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import XCTest
@testable import news_matters

class NewsViewModelTest: XCTestCase {

    func testGetNewsSuccessful() {
        let sut: NewsViewModelProtocol = NewsViewModel(repository: SuccessMockRepositoryProtocol())
        sut.fetchNews()
        XCTAssertEqual(sut.viewData.count, 1)
    }
    
    func testGetNewsFailure() {
        let sut: NewsViewModelProtocol = NewsViewModel(repository: FailureMockRepositoryProtocol())
        sut.fetchNews()
        XCTAssertEqual(sut.viewData.count, 0)
    }

}

class FailureMockRepositoryProtocol: NewsRepositoryProtocol {
    func getNews(completion: @escaping (Result<NewsResponseModel, Error>) -> Void) {
        completion(.failure(APIError.fakeError))
    }
}

class SuccessMockRepositoryProtocol: NewsRepositoryProtocol {
    func getNews(completion: @escaping (Result<NewsResponseModel, Error>) -> Void) {
        completion(.success(TestFactory.aNewsResponse))
    }
}
