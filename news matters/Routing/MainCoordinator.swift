//
//  MainCoordinator.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation
import UIKit

protocol MainCoordinatorProtocol {
    func showNewsDetails(with news: News)
}

struct MainCoordinator: Coordinator, MainCoordinatorProtocol {
    var navigationController: UINavigationController

    func start() {
        let viewModel: NewsViewModelProtocol = NewsViewModel()
        let vc: NewsViewDelegate = NewsView(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showNewsDetails(with news: News) {
        let viewModel: NewsDetailViewProtocol = NewsDetailViewModel(news: news)
        let detailView: NewsDetailViewDelegate = NewsDetailView(viewModel: viewModel)
        navigationController.pushViewController(detailView, animated: true)
    }
}
