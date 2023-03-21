//
//  AppRouter.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import UIKit

final class AppRouter: AppRouterProtocol {

    // MARK: - Properties
    var rootViewController: UINavigationController

    // MARK: - Init
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
}
