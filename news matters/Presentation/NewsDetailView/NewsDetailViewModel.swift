//
//  NewsDetailViewModel.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation
import Combine

typealias NewsDetailViewDataUpdates = PassthroughSubject<String, Never>

protocol NewsDetailViewProtocol {
    var detailUpdate: NewsDetailViewDataUpdates { get }
    func populateDetailData()
}

class NewsDetailViewModel: NewsDetailViewProtocol {
    
    private var news: News
    
    let detailUpdate: NewsDetailViewDataUpdates = .init()
    
    init(news: News) {
        self.news = news
    }
    
    func populateDetailData() {
        detailUpdate.send(news.url)
    }
}
