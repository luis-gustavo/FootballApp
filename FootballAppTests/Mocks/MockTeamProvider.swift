//
//  MockTeamProvider.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import Combine
import Foundation
import Models
import Networking
@testable import FootballApp

final class MockTeamProvider: TeamProviderProtocol {

    // MARK: - TeamProviderProtocol
    func getTeams() -> AnyPublisher<[Models.Team], Networking.NetworkError> {
        let teams: [Models.Team] = [
            .init(id: "1", name: "Team Cool Eagles", logo: "https://www.google.com"),
            .init(id: "2", name: "Team Red Dragons", logo: "https://www.google.com"),
            .init(id: "3", name: "Team Chill Elephants", logo: ""),
            .init(id: "4", name: "Team Royal Knights", logo: "")
        ]
        return Just(teams)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}
