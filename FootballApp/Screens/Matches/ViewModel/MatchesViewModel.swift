//
//  MatchesViewModel.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import Combine
import DIContainer
import Foundation
import Networking
import Models
import Storage

final class MatchesViewModel {

    // MARK: - Properties
    var filteredPreviousMatches: [PreviousMatch] {
        guard !searchText.isEmpty else { return previousMatches }
        let lowerCasedSearchText = searchText.lowercased()
        return previousMatches
            .filter { $0.home.lowercased().contains(lowerCasedSearchText) || $0.away.lowercased().contains(lowerCasedSearchText) }
    }
    var filteredUpcomingMatches: [UpcomingMatch]  {
        guard !searchText.isEmpty else { return upcomingMatches }
        let lowerCasedSearchText = searchText.lowercased()
        return upcomingMatches
            .filter { $0.home.lowercased().contains(lowerCasedSearchText) || $0.away.lowercased().contains(lowerCasedSearchText) }
    }
    @Published private(set) var teams: [Team] = [] {
        didSet {
            print("teams: \(teams.count)")
        }
    }
    @Published private(set) var state: MatchesViewModelState = .loadingTeams
    private(set) var matchesChanged = PassthroughSubject<Void, Never>()
    private var previousMatches: [PreviousMatch] = [] {
        didSet {
            print("previous matches: \(previousMatches.count)")
        }
    }
    private var upcomingMatches: [UpcomingMatch] = [] {
        didSet {
            print("upcoming matches: \(previousMatches.count)")
        }
    }
    private let storage: Storage = DIContainer.make(for: Storage.self)
    private let teamProvider: TeamProviderProtocol
    private let matchesProvider: MatchProviderProtocol
    private let router: MatchesRouterProtocol
    private var bindings = Set<AnyCancellable>()
    private var searchText = "" {
        didSet {
            matchesChanged.send()
        }
    }

    // MARK: - Inits
    init(
        teamProvider: TeamProviderProtocol = TeamProvider(),
        matchesProvider: MatchProviderProtocol = MatchProvider(),
        router: MatchesRouterProtocol
    ) {
        self.teamProvider = teamProvider
        self.matchesProvider = matchesProvider
        self.router = router
    }
}

// MARK: - Internal methods
extension MatchesViewModel {
    func showError(_ error: Error){
        router.showError(error)
    }

    func updateSearchText(_ text: String) {
        searchText = text
    }

    func fetchData() {
        fetchTeams()
    }

    func cellViewModel(for match: Item) -> MatchCellViewModel {
        let imagesUrls = imagesUrls(for: match)
        let viewModel = MatchCellViewModel(
            dateHeaderViewModel: .init(date: match.dateFormatted),
            highlightFooterViewModel: .init(),
            homeViewModel: .init(
                title: match.homeTeam,
                imageUrl: imagesUrls.home,
                status: match.winner == nil ? .idle : match.winner == match.homeTeam ? .winner : .loser
            ),
            awayViewModel: .init(
                title: match.awayTeam,
                imageUrl: imagesUrls.away,
                status: match.winner == nil ? .idle : match.winner == match.homeTeam ? .loser : .winner
            ),
            showHighlight: match.showHighlight
        )
        viewModel.tappedWatchHighlight
            .sink(receiveValue: { [weak self] _ in
                switch match {
                case let .previous(match):
                    self?.showHighlight(match: match)
                default:
                    break
                }
            })
            .store(in: &bindings)

        viewModel.tappedTeamDetail
            .sink(receiveValue: { [weak self] teamName in
                self?.showTeamDetail(teamName: teamName)
            })
            .store(in: &bindings)

        return viewModel
    }
}

// MARK: - Private methods
private extension MatchesViewModel {
    func showHighlight(match: PreviousMatch) {
        guard let url = match.highlightUrl else { return }
        router.showHighlight(from: url)
    }

    func showTeamDetail(teamName: String) {
        guard let team = teams.first(where: { $0.name == teamName }) else { return }
        router.showTeamDetail(team: team)
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

    func tryToFetchTeamsLocally() {
        storage.fetch(entityName: TeamObject.identifier)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .failure:
                    self?.state = .error(.teamsFetch)
                case .finished:
                    self?.fetchMatches()
                }
            }, receiveValue: { [weak self] objects in
                self?.teams = objects?.compactMap { TeamObject(managedObject: $0).team } ?? []
            })
            .store(in: &bindings)
    }

    func fetchTeams() {
        state = .loadingTeams

        let fetchCompletionHandler: (Subscribers.Completion<NetworkError>) -> Void = { [weak self] completion in
            switch completion {
            case .failure:
                self?.tryToFetchTeamsLocally()
            case .finished:
                self?.fetchMatches()
            }
        }

        let fetchValueHandler: ([Team]) -> Void = { [weak self] teams in
            self?.teams = teams
            self?.saveTeamsLocally(teams: teams)
        }

        teamProvider.getTeams()
            .sink(receiveCompletion: fetchCompletionHandler, receiveValue: fetchValueHandler)
            .store(in: &bindings)
    }

    func tryToFetchUpcomingMatchesLocally() {
        storage.fetch(entityName: UpcomingMatchObject.identifier)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .failure:
                    self?.state = .error(.matchesFetch)
                case .finished:
                    self?.state = .finishedLoading
                }
            }, receiveValue: { [weak self] objects in
                self?.upcomingMatches = objects?.compactMap { UpcomingMatchObject(managedObject: $0).match } ?? []
                self?.matchesChanged.send()
            })
            .store(in: &bindings)
    }

    func tryToFetchPreviousMatchesLocally() {
        storage.fetch(entityName: PreviousMatchObject.identifier)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .failure:
                    self?.state = .error(.matchesFetch)
                case .finished:
                    self?.tryToFetchUpcomingMatchesLocally()
                }
            }, receiveValue: { [weak self] objects in
                self?.previousMatches = objects?.compactMap { PreviousMatchObject(managedObject: $0).match } ?? []
            })
            .store(in: &bindings)
    }

    func fetchMatches() {
        state = .loadingMatches

        let fetchCompletionHandler: (Subscribers.Completion<NetworkError>) -> Void = { [weak self] completion in
            switch completion {
            case .failure:
                self?.tryToFetchPreviousMatchesLocally()
            case .finished:
                self?.state = .finishedLoading
            }
        }

        let fetchValueHandler: (Matches) -> Void = { [weak self] matches in
            self?.previousMatches = matches.previous
            self?.upcomingMatches = matches.upcoming
            self?.matchesChanged.send()
            self?.saveMatchesLocally(matches: matches)
        }

        matchesProvider.getMatches()
            .sink(receiveCompletion: fetchCompletionHandler, receiveValue: fetchValueHandler)
            .store(in: &bindings)
    }

    func saveTeamsLocally(teams: [Team]) {
        storage.createTeams(object: teams)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { output in
                print("saved teams locally: \(output)")
            })
            .store(in: &bindings)
    }

    func saveMatchesLocally(matches: Matches) {
        storage.createPreviousMatches(object: matches.previous)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { output in
                print("saved previous matches locally: \(output)")
            })
            .store(in: &bindings)
        storage.createUpcomingMatches(object: matches.upcoming)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { output in
                print("saved upcoming matches locally: \(output)")
            })
            .store(in: &bindings)
    }
}
