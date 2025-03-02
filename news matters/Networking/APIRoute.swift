//
//  APIRoute.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 01/03/2025.
//
import Foundation

typealias Constant = NetworkConstants.Constant


enum APIRoute {
        
    enum ArticleRoute: NetworkRequest {
                
        case mostPopularArticles(request: NewsRequestModel)
        
        var method: HTTPMethod {
            switch self {
            case .mostPopularArticles:
                .get
            }
        }
        
        var route: URL {
            switch self {
            case .mostPopularArticles(let request):
                NetworkConstants.URLs.baseURL.appendingPathComponent("\(Constant.svc)/\(Constant.mostPopular)/\(Constant.version)/\(Constant.mostviewed)/\(request.section)/\(request.period).\(Constant.json)")
            }
        }
        
        var queryParams: Parameters? {
            switch self {
            case .mostPopularArticles:
                [NetworkConstants.Constant.apiKey: NetworkConstants.Key.apiKey]
            }
        }
        
        var bodyParam: Encodable? {
            switch self {
            case .mostPopularArticles:
                nil
            }
        }
        
    }
}
