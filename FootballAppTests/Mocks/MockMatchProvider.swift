//
//  MockMatchProvider.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import Combine
import Foundation
import Models
import Networking
@testable import FootballApp

final class MockMatchProvider: MatchProviderProtocol {

    // MARK: - MatchProviderProtocol
    func getMatches() -> AnyPublisher<Matches, NetworkError> {
        let upcoming: [UpcomingMatch] = [
            .init(
                description: "Team Red Dragons vs. Team Cool Eagles",
                home: "Team Red Dragons",
                away: "Team Cool Eagles",
                date: "2022-04-23T16:00:00.000Z"
            ),
            .init(
                description: "Team Cool Eagles vs. Team Red Dragons",
                home: "Team Cool Eagles",
                away: "Team Red Dragons",
                date: "2022-04-23T18:00:00.000Z"
            )
        ]
        let previous: [PreviousMatch] = [
            .init(
                description: "Team Cool Eagles vs. Team Red Dragons",
                home: "Team Cool Eagles",
                away: "Team Red Dragons",
                winner: "Team Red Dragons",
                highlights: "https://tstzj.s3.amazonaws.com/highlights.mp4",
                date: "2022-04-23T18:00:00.000Z"
            ),
            .init(
                description: "Team Chill Elephants vs. Team Royal Knights",
                home: "Team Chill Elephants",
                away: "Team Royal Knights",
                winner: "Team Chill Elephants",
                highlights: "https://tstzj.s3.amazonaws.com/highlights.mp4",
                date: "2022-04-24T18:00:00.000Z"
            )
        ]
        let matches = Matches(previous: previous, upcoming: upcoming)
        return Just(matches)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}
