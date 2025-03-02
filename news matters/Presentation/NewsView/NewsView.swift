//
//  NewsView.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import UIKit
import Combine

protocol NewsViewDelegate where Self: UIViewController { }

class NewsView: UIViewController, NewsViewDelegate {
    
    private let viewModel: NewsViewModelProtocol
    private let coordinator: MainCoordinatorProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    private var tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    init(viewModel: NewsViewModelProtocol, coordinator: MainCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableViewConstrains()
        setupNavigationBar()
        setupTableView()
        
        subscribeUpdates()
        viewModel.fetchNews()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }
    
    private func setupTableViewConstrains() {
        let safeAreaLayout = self.view.safeAreaLayoutGuide
        
        tableView.topAnchor.constraint(equalTo: safeAreaLayout.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayout.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayout.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayout.trailingAnchor).isActive = true
    }
    

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        tableView.register(NewsCell.self, forCellReuseIdentifier: String(describing: NewsCell.self))
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = String(localized: "home_title")
    }
}
extension NewsView: Toastable {
    private func subscribeUpdates() {
        viewModel.updates
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] state in
                switch state {
                case .dataUpdated:
                    self?.reloadData()
                case .error(let error):
                    self?.show(error: error.localizedDescription)
                }
                
            }).store(in: &cancellables)
    }
    
    private func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    private func show(error: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.showToast(message: error)
        }
    }
}

extension NewsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.viewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsCell.self), for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        cell.setupView()
        cell.news = viewModel.viewData[indexPath.row]
        return cell
    }
}

extension NewsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = viewModel.viewData[indexPath.row]
        coordinator.showNewsDetails(with: news)
    }
}
