//
//  NewsDetailViewModel.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation

protocol NewsDetailViewBinder: class {
    func showDetails(with detail: String)
}

class NewsDetailViewModel {
    
    private var news: NewsDataModel
    
    init(news: NewsDataModel) {
        self.news = news
    }
    weak var binder: NewsDetailViewBinder?
    
    func populateDetailData() {
        binder?.showDetails(with: news.title)
    }
 
}
