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
        let vc: NewsView = NewsView(viewModel: NewsViewModel(), coordinator: self)
        navigationController.pushViewController(vc, animated: false)
    }
    
    //TODO: Maniar - Child Coordinator
    func showNewsDetails(with news: News) {
        let viewModel: NewsDetailViewBinder = NewsDetailViewModel(news: news)
        let detailView: NewsDetailViewProtocol = NewsDetailView(viewModel: viewModel)
        navigationController.pushViewController(detailView, animated: true)
    }
}
