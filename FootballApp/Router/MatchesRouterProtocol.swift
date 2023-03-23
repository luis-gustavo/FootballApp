//
//  MatchesRouterProtocol.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import AVKit
import Models
import UIKit

protocol MatchesRouterProtocol {
    var rootViewController: UINavigationController { get set }
    func showTeamDetail(team: Team)
    func showHighlight(from url: URL)
    func showError(_ error: Error)
}

extension MatchesRouterProtocol {
    func showTeamDetail(team: Team) {
        let viewController = TeamDetailViewController(viewModel: .init(
            title: team.name,
            logoImageUrl: team.imageUrl
        ))
        rootViewController.pushViewController(viewController, animated: true)
    }

    func showHighlight(from url: URL) {
        DispatchQueue.main.async {
            let playerViewController = AVPlayerViewController()
            playerViewController.player = AVPlayer(url: url)
            self.rootViewController.pushViewController(playerViewController, animated: true)
            playerViewController.player?.play()
        }
    }

    func showError(_ error: Error) {
        rootViewController.showAlert(
            with: Localizable.error.localized,
            message: error.localizedDescription
        )
    }
}
