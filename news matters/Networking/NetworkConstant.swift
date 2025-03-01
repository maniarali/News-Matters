//
//  NetworkConstant.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 01/03/2025.
//

import Foundation

enum NetworkConstants {

    enum Constant {
        static let version = "v2"
        static let svc = "svc"
        static let apiKey = "api-key"
        static let mostPopular = "mostpopular"
        static let mostviewed = "mostviewed"
        static let allSections = "all-sections"
        static let period = 7
        static let json = "json"
    }
    
    enum Key {
        static let apiKey = "MAw75O5xbL7htYq8VccOoMt4Z2rEH1uA"
    }
    
    enum URLs {
        static let baseURL = URL(string: "https://api.nytimes.com/")!
    }
    
}
