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
    private var cancellable: AnyCancellable?
    
    init(repository: NewsRepositoryProtocol = NewsRepository()) {
        self.repository = repository
    }
    
    func fetchNews() {
        cancellable = repository.getNews()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                if case .failure(let error) = completion {
                    self.updates.send(.error(error))
                }
            } receiveValue: { [weak self] news in
                guard let self else { return }
                self.viewData.append(contentsOf: news)
            }
    }
    
}
