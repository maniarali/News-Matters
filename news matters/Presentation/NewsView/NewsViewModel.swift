//
//  NewsViewModel.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation

protocol NewsViewModelBinder: AnyObject {
    var binder: NewsViewProtocol? { get set }
    var viewData: [News] { get }
    
    func fetchNews() -> Void
}

class NewsViewModel: NewsViewModelBinder {
    
    weak var binder: NewsViewProtocol?
    private var repository: NewsRepositoryProtocol
    
    private(set) var viewData: [News] = []
    
    init(repository: NewsRepositoryProtocol = NewsRepository()) {
        self.repository = repository
    }
    
    func fetchNews() {
        repository.getNews { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                self.viewData.append(contentsOf: model.results)
                self.binder?.reloadData()
            case .failure(let error):
                self.binder?.show(error: error.localizedDescription)
            }
        }
    }
    
}
