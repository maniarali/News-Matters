//
//  MainCoordinator.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc: NewsView = NewsView.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showNewsDetails(with news: News) {
        let detailView: NewsDetailView = NewsDetailView.instantiate()
        detailView.viewModel = NewsDetailViewModel(news: news)
        navigationController.pushViewController(detailView, animated: true)
    }
}
