//
//  SceneDelegate.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = appRouter.rootViewController
        window.makeKeyAndVisible()
        appRouter.showMatches()
        self.window = window
    }
}

// MARK: - AppRoot
private enum AppRoot {
    static let appRouter = AppRouter(rootViewController: UINavigationController())
}

// MARK: - AppRouter
private extension SceneDelegate {
    var appRouter: AppRouterProtocol { AppRoot.appRouter }
}
