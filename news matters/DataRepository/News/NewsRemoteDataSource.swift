//
//  NewsRemoteDataSource.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation

protocol NewsRemoteDataSourceProtocol {
    func getNews(for section: String, period: Int, completion: @escaping (Result<NewsResponseModel, Error>) -> Void)
}

class NewsRemoteDataSource: NewsRemoteDataSourceProtocol {
    
    private var network: NetworkLayerProtocol
    
    init(network: NetworkLayerProtocol = NetworkLayer()) {
        self.network = network
    }
    
    func getNews(for section: String, period: Int, completion: @escaping (Result<NewsResponseModel, Error>) -> Void) {
        let mostPopularRequest = APIRoute.ArticleRoute.mostPopularArticles(section: section, period: period)
        network.perform(request: mostPopularRequest, completion: completion)
    }
}
