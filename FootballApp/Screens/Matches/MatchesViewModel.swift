//
//  MatchesViewModel.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import Combine
import Foundation
import Networking

enum MatchesViewModelError: Error, Equatable {
    case teamsFetch
    case matchesFetch
}

enum MatchesViewModelState {
    case loadingTeams
    case loadingMatches
    case finishedLoading
    case error(MatchesViewModelError)
}

final class MatchesViewModel {

    // MARK: - Secion
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
            case let .upcoming(match):
                return nil
            }
        }
    }

    // MARK: - Properties
    @Published private(set) var teams: [Team] = []
    @Published private(set) var previousMatches: [PreviousMatch] = []
    @Published private(set) var upcomingMatches: [UpcomingMatch] = []
    @Published private(set) var state: MatchesViewModelState = .loadingTeams
    private let teamProvider: TeamProviderProtocol
    private let matchesProvider: MatchProviderProtocol
    private var bindings = Set<AnyCancellable>()

    // MARK: - Inits
    init(
        teamProvider: TeamProviderProtocol = TeamProvider(),
        matchesProvider: MatchProviderProtocol = MatchProvider()
    ) {
        self.teamProvider = teamProvider
        self.matchesProvider = matchesProvider
    }
}

// MARK: - Internal methods
extension MatchesViewModel {
    func fetchData() {
        fetchTeams()
        fetchMatches()
    }

    func imagesUrls(for item: Item) -> (home: URL?, away: URL?) {
        let homeTeam: String
        let awayTeam: String
        switch item {
        case let .previous(match):
            homeTeam = match.home
            awayTeam = match.away
        case let .upcoming(match):
            homeTeam = match.home
            awayTeam = match.away
        }
        let homeTeamImageUrl = teams.first { $0.name == homeTeam }?.imageUrl
        let awayTeamImageUrl = teams.first { $0.name == awayTeam }?.imageUrl
        return (home: homeTeamImageUrl, away: awayTeamImageUrl)
    }
}

// MARK: - Private methods
private extension MatchesViewModel {
    func fetchTeams() {
        state = .loadingTeams

        let fetchCompletionHandler: (Subscribers.Completion<NetworkError>) -> Void = { [weak self] completion in
            switch completion {
            case .failure:
                self?.state = .error(.teamsFetch)
            case .finished:
                self?.fetchMatches()
            }
        }

        let fetchValueHandler: ([Team]) -> Void = { [weak self] teams in
            self?.teams = teams
        }

        teamProvider.getTeams()
            .sink(receiveCompletion: fetchCompletionHandler, receiveValue: fetchValueHandler)
            .store(in: &bindings)
    }

    func fetchMatches() {
        state = .loadingMatches

        let fetchCompletionHandler: (Subscribers.Completion<NetworkError>) -> Void = { [weak self] completion in
            switch completion {
            case .failure:
                self?.state = .error(.teamsFetch)
            case .finished:
                self?.state = .finishedLoading
            }
        }

        let fetchValueHandler: (Matches) -> Void = { [weak self] matches in
            self?.previousMatches = matches.previous
            self?.upcomingMatches = matches.upcoming
        }

        matchesProvider.getMatches()
            .sink(receiveCompletion: fetchCompletionHandler, receiveValue: fetchValueHandler)
            .store(in: &bindings)
    }
}
