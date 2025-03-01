//
//  Networking.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 01/03/2025.
//

import Foundation

typealias Parameters = [String : String]

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol URLRequestConvertable {
    func asURLRequest() -> URLRequest
}

protocol NetworkRequest: URLRequestConvertable {
    var method: HTTPMethod { get }
    var route: URL { get }
    var queryParams: Parameters? { get }
    var bodyParam: Encodable? { get }
}

extension NetworkRequest {
    
    func asURLRequest() -> URLRequest {
        var urlRequest = URLRequest(url: route)
        urlRequest.httpMethod = method.rawValue
        if let queryParams {
            urlRequest.url?.append(queryItems: queryParams.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        if let bodyParam, let data = try? JSONEncoder().encode(bodyParam) {
            urlRequest.httpBody = data
        }
        return urlRequest
    }
}
