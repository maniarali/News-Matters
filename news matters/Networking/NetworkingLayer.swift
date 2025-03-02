//
//  NetworkingLayer.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation
import Combine

protocol NetworkLayerProtocol {
    func perform<A: Decodable>(request: URLRequestConvertable) -> AnyPublisher<A, Error>
}

struct NetworkLayer: NetworkLayerProtocol {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func perform<A: Decodable>(request: URLRequestConvertable) -> AnyPublisher<A, Error> {
        session
            .dataTaskPublisher(for: request.asURLRequest())
            .tryMap() { element -> Data in
                guard let response = element.response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    throw NetworkError.responseCodeError
                }
                return element.data
            }
            .decode(type: A.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

enum NetworkError: Error {
    case clientError
    case responseCodeError
    case mimeTypeError
    case invalidURL
    case jsonDecodingError
}
