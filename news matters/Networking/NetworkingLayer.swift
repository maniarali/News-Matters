//
//  NetworkingLayer.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation

protocol NetworkLayerProtocol {
    func perform<A>(request: URLRequestConvertable, completion: @escaping (Result<A, Error>) -> Void) where A: Decodable
}

class NetworkLayer: NetworkLayerProtocol {
    
    private var session: URLSession
    private var task: URLSessionDataTask?
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    //MARK: Maniar - Generic not only Get
    /// Perform POST request
    /// - Parameters:
    ///   - url: Remote API endpoint
    ///   - parameters: Request's JSON data
    ///   - completion: Completion handler that either return response's JSON data or error
    func perform<A>(request: URLRequestConvertable, completion: @escaping (Result<A, Error>) -> Void) where A : Decodable {
        self.task = session.dataTask(with: request.asURLRequest()) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(NetworkError.clientError))
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(NetworkError.responseCodeError))
                return
            }

            guard let mime = response.mimeType, mime == "application/json" else {
                completion(.failure(NetworkError.mimeTypeError))
                return
            }
            do {
                let model = try JSONDecoder().decode(A.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(NetworkError.jsonDecodingError))
            }
            
        }
        task?.resume()
    }
}

enum NetworkError: Error {
    case clientError
    case responseCodeError
    case mimeTypeError
    case invalidURL
    case jsonDecodingError
}
