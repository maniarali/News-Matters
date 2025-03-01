//
//  NewsDetailViewModel.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation

protocol NewsDetailViewBinder: AnyObject {
    var binder: NewsDetailViewProtocol? { get set }
    func populateDetailData()
}

class NewsDetailViewModel: NewsDetailViewBinder {
    
    private var news: News
    weak var binder: NewsDetailViewProtocol?
    
    init(news: News) {
        self.news = news
    }
    
    
    func populateDetailData() {
        binder?.showDetails(with: news.url)
    }
 
}
