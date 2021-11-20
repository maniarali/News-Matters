//
//  NewsView.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import UIKit

class NewsView: UIViewController, Routable {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
    }
    
    private func setupView() {
        viewModel.binder = self
        viewModel.getNews()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
extension NewsView: NewsViewBinder {
    func reloadData() {
        tableView.reloadData()
    }
}

extension NewsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.viewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let news = viewModel.viewData[indexPath.row]
        cell.textLabel?.text = news.title
        cell.detailTextLabel?.text = news.author
        return cell
    }
}
extension NewsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = viewModel.viewData[indexPath.row]
        self.showNewsDetails(with: news)
    }
    
    private func showNewsDetails(with news: NewsDataModel) {
        let detailView: NewsDetailView = NewsDetailView.instantiate()
        detailView.viewModel = NewsDetailViewModel(news: news)
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}
