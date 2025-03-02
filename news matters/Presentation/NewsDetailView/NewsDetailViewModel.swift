//
//  NewsDetailViewModel.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation

protocol NewsDetailViewProtocol {
    var delegate: NewsDetailViewDelegate? { get set }
    func populateDetailData()
}

class NewsDetailViewModel: NewsDetailViewProtocol {
    
    private var news: News
    weak var delegate: NewsDetailViewDelegate?
    
    init(news: News) {
        self.news = news
    }
    
    
    func populateDetailData() {
        delegate?.showDetails(with: news.url)
    }
 
}
