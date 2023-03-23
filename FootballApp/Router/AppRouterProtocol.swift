//
//  AppRouterProtocol.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import UIKit

protocol AppRouterProtocol: MatchesRouterProtocol {
    var rootViewController: UINavigationController { get set }
    func showMatches()
}

extension AppRouterProtocol {
    func showMatches() {
        rootViewController.navigationBar.prefersLargeTitles = true
        let viewModel = MatchesViewModel(
            teamProvider: TeamProvider(),
            matchesProvider: MatchProvider(),
            router: self,
            fileManagerProvider: FileManagerProvider.shared
        )
        let viewController = MatchesViewController(viewModel: viewModel)
        viewController.navigationItem.largeTitleDisplayMode = .automatic
        rootViewController.setViewControllers([viewController], animated: true)
    }
}
