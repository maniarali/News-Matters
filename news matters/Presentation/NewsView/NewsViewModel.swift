//
//  NewsViewModel.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation

protocol NewsViewBinder: class {
    func reloadData()
    func show(error: String)
}

class NewsViewModel {
    
    weak var binder: NewsViewBinder?
    var repository: NewsRepositoryProtocol
    var viewData: [News] = []
    
    init(repository: NewsRepositoryProtocol = NewsRepository()) {
        self.repository = repository
    }
    
    func getNews() {
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
