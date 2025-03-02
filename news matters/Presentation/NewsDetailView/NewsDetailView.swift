//
//  NewsDetailView.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import UIKit
import WebKit
import Combine

protocol NewsDetailViewDelegate where Self: UIViewController { }

class NewsDetailView: UIViewController, NewsDetailViewDelegate {
    
    private var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private(set) var cancellable: Set<AnyCancellable> = []
    
    private let viewModel: NewsDetailViewProtocol
    
    init(viewModel: NewsDetailViewProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupWebViewConstrains()
        
        subscribeUpdate()
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

extension NewsDetailView {
    private func subscribeUpdate() {
        self.viewModel.detailUpdate
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] url in
                self.showDetails(with: url)
            }.store(in: &cancellable)
    }
    
    private func showDetails(with detail: String) {
        guard let url = URL(string: detail) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
