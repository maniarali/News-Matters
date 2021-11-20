//
//  NewsModel.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation

struct NewsResponseModel: Decodable {
    var status: String
    var numResults: Int
    var results: [News]
    
    enum CodingKeys: String, CodingKey {
        case status, results
        case numResults = "num_results"
    }
}

struct News: Decodable {
    var id: Int
    var url: String

    var title: String
    var byline: String
    var publishedDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, url, title, byline
        case publishedDate = "published_date"
    }
}
