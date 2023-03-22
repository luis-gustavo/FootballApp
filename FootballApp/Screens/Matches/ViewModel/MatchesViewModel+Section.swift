//
//  MatchesViewModel+Section.swift
//  FootballApp
//
//  Created by Luis Gustavo on 22/03/23.
//

import Foundation

extension MatchesViewModel {

    // MARK: - Section
    enum Section: CaseIterable, Hashable {
        case previous, upcoming

        var title: String {
            switch self {
            case .previous:
                return Localizable.previous.localized
            case .upcoming:
                return Localizable.upcoming.localized
            }
        }
    }
}
