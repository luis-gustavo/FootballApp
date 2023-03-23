//
//  TestingAppDelegate.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import Foundation
import DIContainer
import Networking
import Storage
import UIKit
@testable import FootballApp

@objc(TestingAppDelegate)
final class TestingAppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
         registerServices()

        // Remove any cached scene configurations to ensure that TestingAppDelegate.application(_:configurationForConnecting:options:) is called and TestingSceneDelegate will be used when running unit tests. NOTE: THIS IS PRIVATE API AND MAY BREAK IN THE FUTURE!
        for sceneSession in application.openSessions {
            application.perform(Selector(("_removeSessionFromSessionSet:")), with: sceneSession)
        }

        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            // Called when a new scene session is being created.
            // Use this method to select a configuration to create the new scene with.
            let sceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
            sceneConfiguration.delegateClass = TestingSceneDelegate.self
            sceneConfiguration.storyboard = nil

            return sceneConfiguration
        }

    private func registerServices() {
        DIContainer.register(URLSessionNetworkingProtocol.self, maker: { URLSessionNetworking.shared })
        DIContainer.register(Storage.self, maker: { MockStorage.shared })
        DIContainer.register(ImageLoaderProtocol.self, maker: { MockImageLoader.shared })
    }
}
