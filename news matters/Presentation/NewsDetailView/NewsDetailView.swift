//
//  NewsDetailView.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import UIKit
import WebKit

class NewsDetailView: UIViewController, Routable {
    
    @IBOutlet weak var webview: WKWebView!
    var viewModel: NewsDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.binder = self
        viewModel?.populateDetailData()
    }
}

extension NewsDetailView: NewsDetailViewBinder {
    func showDetails(with detail: String) {
        let url = URL(string: detail)!
        let urlRequest = URLRequest(url: url)
        webview.load(urlRequest)
    }
}
