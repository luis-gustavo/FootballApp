//
//  MockMatchesRouterProtocol.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import Models
import UIKit
@testable import FootballApp

final class MockMatchesRouter: MatchesRouterProtocol {

    var rootViewController: UINavigationController = UINavigationController()
    var tappedShowDetail = false
    var tappedShowHighlight = false
    var tappedShowError = false

    // MARK: - MatchesRouterProtocol
    func showTeamDetail(team: Team) {
        tappedShowDetail = true
    }

    func showHighlight(from url: URL) {
        tappedShowHighlight = true
    }

    func showError(_ error: Error) {
        tappedShowError = true
    }
}
