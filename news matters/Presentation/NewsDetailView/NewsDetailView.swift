//
//  NewsDetailView.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import UIKit

class NewsDetailView: UIViewController, Routable {

    @IBOutlet weak var detailTextView: UITextView!
    
    var viewModel: NewsDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.binder = self
        viewModel?.populateDetailData()
    }
}

extension NewsDetailView: NewsDetailViewBinder {
    func showDetails(with detail: String) {
        detailTextView.text = detail
    }
}
