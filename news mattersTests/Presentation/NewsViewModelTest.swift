//
//  NewsViewModelTest.swift
//  news mattersTests
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import XCTest
@testable import news_matters

class NewsViewModelTest: XCTestCase {

    var sut: NewsViewModel = NewsViewModel()

    func testGetNewsSuccessful() {
        sut = NewsViewModel(repository: SuccessMockRepositoryProtocol())
        sut.fetchNews()
        XCTAssertEqual(sut.viewData.count, 1)
    }
    
    func testGetNewsFailure() {
        sut = NewsViewModel(repository: FailureMockRepositoryProtocol())
        sut.fetchNews()
        XCTAssertEqual(sut.viewData.count, 0)
    }

}
enum APIError: Error {
    case fakeError
}
class FailureMockRepositoryProtocol: NewsRepositoryProtocol {
    func getNews(completion: @escaping (Result<NewsResponseModel, Error>) -> Void) {
        completion(.failure(APIError.fakeError))
    }
}

class SuccessMockRepositoryProtocol: NewsRepositoryProtocol {
    func getNews(completion: @escaping (Result<NewsResponseModel, Error>) -> Void) {
        let news: [News] = [News(id: 100000008080806, url: "https://www.nytimes.com", title: "New York Times", byline: "Authors", publishedDate: "2021-11-20", media: [])]
        let model = NewsResponseModel(status: "OK", numResults: news.count, results: news)
        completion(.success(model))
    }
}
