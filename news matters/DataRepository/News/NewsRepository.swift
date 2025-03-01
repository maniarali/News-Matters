//
//  NewsRepository.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation

protocol NewsRepositoryProtocol {
    func getNews(completion: @escaping (Result<NewsResponseModel, Error>) -> Void)
}

/// Repository layer which is resposible to provide data in app
/// This layer can have different soruce to provide data in app i.e Remote, Local. 
class NewsRepository: NewsRepositoryProtocol {
    
    private var remote: NewsRemoteDataSourceProtocol
    
    init(remote: NewsRemoteDataSourceProtocol = NewsRemoteDataSource()) {
        self.remote = remote
    }
    
    func getNews(completion: @escaping (Result<NewsResponseModel, Error>) -> Void) {
        // Fetch data from remote repository only
        // Data can also be provided from local repository if needed.
        remote.getNews(for: Constant.allSections, period: Constant.period, completion: completion)
    }
}
