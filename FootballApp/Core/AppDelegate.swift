//
//  AppDelegate.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import CoreData
import DIContainer
import Networking
import Storage
import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        registerServices()
        return true
    }
}

// MARK: - Private methods
private extension AppDelegate {
    func registerServices() {
        DIContainer.register(URLSessionNetworkingProtocol.self, maker: { URLSessionNetworking.shared })
        DIContainer.register(ImageLoaderProtocol.self) { ImageLoader.shared }
        DIContainer.register(Storage.self) { StorageManager() }
    }
}
