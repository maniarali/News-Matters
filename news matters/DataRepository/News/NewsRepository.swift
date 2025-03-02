//
//  NewsRepository.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation
import Combine

protocol NewsRepositoryProtocol {
    func getNews() -> AnyPublisher<[News], Error>
}

/// Repository layer which is resposible to provide data in app
/// This layer can have different soruce to provide data in app i.e Remote, Local. 
class NewsRepository: NewsRepositoryProtocol {
    
    private var remote: NewsRemoteDataSourceProtocol
    
    init(remote: NewsRemoteDataSourceProtocol = NewsRemoteDataSource()) {
        self.remote = remote
    }
    
    func getNews() -> AnyPublisher<[News], Error> {
        // Fetch data from remote repository only
        // Data can also be provided from local repository if needed.
        return remote
            .getNews(for: NewsRequestModel(section: Constant.allSections, period: Constant.period))
            .map(\.results)
            .eraseToAnyPublisher()
    }
}
