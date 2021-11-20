//
//  NewsViewModel.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation

protocol NewsViewBinder: class {
    func reloadData()
}

class NewsViewModel {
    
    weak var binder: NewsViewBinder?
    
    var viewData: [NewsDataModel] = []
    
    func getNews() {
        viewData.append(NewsDataModel(title: "Supports of the Democratic candidate Jon Ossoff after his ...", author: "By DAVID LEONHARDT and STUART . THOMPSON", date: "2017-06-03", image: ""))
        viewData.append(NewsDataModel(title: "Supports of the Democratic candidate Jon Ossoff after his ...", author: "By DAVID LEONHARDT and STUART . THOMPSON", date: "2017-06-03", image: ""))
        viewData.append(NewsDataModel(title: "Supports of the Democratic candidate Jon Ossoff after his ...", author: "By DAVID LEONHARDT and STUART . THOMPSON", date: "2017-06-03", image: ""))
        
        binder?.reloadData()
    }
    
}

struct NewsDataModel {
    var title: String
    var author: String
    var date: String
    var image: String
}
