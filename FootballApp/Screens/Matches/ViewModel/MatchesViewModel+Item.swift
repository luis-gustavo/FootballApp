//
//  MatchesViewModel+Item.swift
//  FootballApp
//
//  Created by Luis Gustavo on 22/03/23.
//

import Foundation
import Models

extension MatchesViewModel {
    // MARK: - Item
    enum Item: Hashable {
        case previous(PreviousMatch),
             upcoming(UpcomingMatch)

        var homeTeam: String {
            switch self {
            case let .previous(match):
                return match.home
            case let .upcoming(match):
                return match.home
            }
        }

        var homeTeamId: String {
            switch self {
            case let .previous(match):
                return match.home
            case let .upcoming(match):
                return match.home
            }
        }

        var awayTeam: String {
            switch self {
            case let .previous(match):
                return match.away
            case let .upcoming(match):
                return match.away
            }
        }

        var dateFormatted: String {
            switch self {
            case let .previous(match):
                return match.dateFormatted ?? ""
            case let .upcoming(match):
                return match.dateFormatted ?? ""
            }
        }

        var winner: String? {
            switch self {
            case let .previous(match):
                return match.winner
            case .upcoming:
                return nil
            }
        }

        var showHighlight: Bool {
            switch self {
            case .previous:
                return true
            case .upcoming:
                return false
            }
        }
    }
}
