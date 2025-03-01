//
//  NewsDetailView.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import UIKit
import WebKit

protocol NewsDetailViewProtocol: AnyObject where Self: UIViewController {
    func showDetails(with detail: String)
}

class NewsDetailView: UIViewController {
    
    private var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private(set) var viewModel: NewsDetailViewBinder
    
    init(viewModel: NewsDetailViewBinder) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.binder = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupWebViewConstrains()
        
        viewModel.populateDetailData()
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.webView)
    }
    
    private func setupWebViewConstrains() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension NewsDetailView: NewsDetailViewProtocol {
    func showDetails(with detail: String) {
        let url = URL(string: detail)!
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
