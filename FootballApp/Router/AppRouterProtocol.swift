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
        let viewController = MatchesViewController(viewModel: .init(router: self))
        viewController.navigationItem.largeTitleDisplayMode = .automatic
        rootViewController.setViewControllers([viewController], animated: true)
    }
}
