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
            .filter {
                $0.home.lowercased().contains(lowerCasedSearchText)
                || $0.away.lowercased().contains(lowerCasedSearchText)
            }
    }
    var filteredUpcomingMatches: [UpcomingMatch] {
        guard !searchText.isEmpty else { return upcomingMatches }
        let lowerCasedSearchText = searchText.lowercased()
        return upcomingMatches
            .filter { $0.home.lowercased().contains(lowerCasedSearchText) ||
                $0.away.lowercased().contains(lowerCasedSearchText)
            }
    }
    @Published private(set) var teams: [Team] = []
    @Published private(set) var state: MatchesViewModelState = .loading
    private(set) var dataChanged = PassthroughSubject<Void, Never>()
    private var previousMatches: [PreviousMatch] = []
    private var upcomingMatches: [UpcomingMatch] = []
    private let storage: Storage = DIContainer.make(for: Storage.self)
    private let teamProvider: TeamProviderProtocol
    private let matchesProvider: MatchProviderProtocol
    private let router: MatchesRouterProtocol
    private let fileManagerProvider: FileManagerProviderProtocol
    private var bindings = Set<AnyCancellable>()
    private var searchText = "" {
        didSet {
            dataChanged.send()
        }
    }

    // MARK: - Inits
    init(
        teamProvider: TeamProviderProtocol,
        matchesProvider: MatchProviderProtocol,
        router: MatchesRouterProtocol,
        fileManagerProvider: FileManagerProviderProtocol
    ) {
        self.teamProvider = teamProvider
        self.matchesProvider = matchesProvider
        self.router = router
        self.fileManagerProvider = fileManagerProvider
    }
}

// MARK: - Internal methods
extension MatchesViewModel {
    func showError(_ error: Error) {
        router.showError(error)
    }

    func updateSearchText(_ text: String) {
        searchText = text
    }

    func fetchData() {
        tryToFetchDataFromServer()
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
        if fileManagerProvider.fileExists(name: match.highlights),
           let localUrl = fileManagerProvider.retrieveUrlFromDocuments(name: match.highlights) {
            router.showHighlight(from: localUrl)
        } else if let remoteUrl = match.highlightUrl {
            router.showHighlight(from: remoteUrl)
        }
    }

    func showTeamDetail(teamName: String) {
        guard let team = teams.first(where: {
            $0.name.trimmingCharacters(
                in: .whitespacesAndNewlines
            ) == teamName.trimmingCharacters(
                in: .whitespacesAndNewlines
            )
        }) else { return }
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

    func saveDataLocally(teams: [Team], previousMatches: [PreviousMatch], upcomingMatches: [UpcomingMatch]) {
        storage.createTeams(object: teams)
            .combineLatest(
                storage.createPreviousMatches(object: previousMatches),
                storage.createUpcomingMatches(object: upcomingMatches)
            )
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { output in
                print("saved teams locally: \(output.0)")
                print("saved previous matches locally: \(output.1)")
                print("saved upcoming matches locally: \(output.2)")
            })
            .store(in: &bindings)
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self else { return }
            for match in previousMatches where !self.fileManagerProvider.fileExists(name: match.highlights) {
                self.fileManagerProvider.saveToDocuments(name: match.highlights)
            }
        }
    }

    func tryToFetchDataFromServer() {
        state = .loading

        let completionHandler: (Subscribers.Completion<NetworkError>) -> Void = { [weak self] completion in
            switch completion {
            case .failure:
                self?.tryToFetchDataLocally()
            case .finished:
                self?.state = .finishedLoading
            }
        }

        let valueHandler: ([Team], Matches) -> Void = { [weak self] teams, matches in
            self?.teams = teams
            self?.previousMatches = matches.previous
            self?.upcomingMatches = matches.upcoming
            self?.saveDataLocally(
                teams: teams,
                previousMatches: matches.previous,
                upcomingMatches: matches.upcoming
            )
            self?.dataChanged.send()
        }

        teamProvider.getTeams()
            .combineLatest(matchesProvider.getMatches())
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }

    func tryToFetchDataLocally() {
        storage.fetch(entityName: TeamObject.identifier)
            .combineLatest(
                storage.fetch(entityName: PreviousMatchObject.identifier),
                storage.fetch(entityName: UpcomingMatchObject.identifier)
            )
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure:
                    self?.state = .error(.dataFetch)
                case .finished:
                    self?.state = .finishedLoading
                }
            }, receiveValue: { [weak self] output in
                self?.teams = output.0?.compactMap { TeamObject(managedObject: $0).team } ?? []
                self?.previousMatches = output.1?.compactMap { PreviousMatchObject(managedObject: $0).match } ?? []
                self?.upcomingMatches = output.2?.compactMap { UpcomingMatchObject(managedObject: $0).match } ?? []
                self?.dataChanged.send()
            })
            .store(in: &bindings)
    }
}
