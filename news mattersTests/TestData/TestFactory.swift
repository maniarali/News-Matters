//
//  aNews.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 02/03/2025.
//
@testable import news_matters

enum TestFactory {
    static var aNews: News = News(id: 100000008080806, url: "https://www.nytimes.com", title: "New York Times", byline: "Authors", publishedDate: "2021-11-20", media: [])
    static var aNewsResponse: NewsResponseModel = NewsResponseModel(status: "OK", numResults: 1, results: [TestFactory.aNews])
}

enum APIError: Error {
    case fakeError
}
