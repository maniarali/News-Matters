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
        guard let url = constructNYURL(parameters: "\(section)/\(period)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        network.get(url: url, completion: completion)
    }
    
    @available(*, deprecated, message: "Shall be removed from here and provide better class to construct URL")
    func constructNYURL(parameters: String) -> URL? {
        let baseURL = "https://api.nytimes.com/svc/"
        let category = "mostpopular"
        let version = "v2"
        let key = "MAw75O5xbL7htYq8VccOoMt4Z2rEH1uA"
        return URL(string: "\(baseURL)/\(category)/\(version)/mostviewed/\(parameters).json?api-key=\(key)")
    }
}
