//
//  NewsRemoteDataSource.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation
import Combine

protocol NewsRemoteDataSourceProtocol {
    func getNews(for request: NewsRequestModel) -> AnyPublisher<NewsResponseModel, Error>
}

class NewsRemoteDataSource: NewsRemoteDataSourceProtocol {
    
    private var network: NetworkLayerProtocol
    
    init(network: NetworkLayerProtocol = NetworkLayer()) {
        self.network = network
    }
    
    func getNews(for request: NewsRequestModel) -> AnyPublisher<NewsResponseModel, Error> {
        let mostPopularRequest = APIRoute.ArticleRoute.mostPopularArticles(request: request)
        let response: AnyPublisher<NewsResponseModel, Error>
        response = network.perform(request: mostPopularRequest)
        return response.eraseToAnyPublisher()
    }
}
