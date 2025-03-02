//
//  NewsViewModel.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation
import Combine

typealias NewsViewUpdates = PassthroughSubject<NewsViewModel.State, Never>

protocol NewsViewModelProtocol: AnyObject {
    var updates: NewsViewUpdates { get }
    var viewData: [News] { get }
    
    func fetchNews() -> Void
}

class NewsViewModel: NewsViewModelProtocol {
    enum State {
        case dataUpdated
        case error(Error)
    }
    
    private var repository: NewsRepositoryProtocol
    
    private(set) var viewData: [News] = [] {
        didSet {
            self.updates.send(.dataUpdated)
        }
    }
    private(set) var updates: NewsViewUpdates = .init()
    
    init(repository: NewsRepositoryProtocol = NewsRepository()) {
        self.repository = repository
    }
    
    func fetchNews() {
        repository.getNews { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.viewData.append(contentsOf: model.results)
            case .failure(let error):
                self.updates.send(.error(error))
            }
        }
    }
    
}
