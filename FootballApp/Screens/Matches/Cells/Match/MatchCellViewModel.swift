//
//  MatchCellViewModel.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import Combine
import Foundation

final class MatchCellViewModel {

    // MARK: - Properties
    let dateHeaderViewModel: DateHeaderViewModel
    let highlightFooterViewModel: HighlightFooterViewModel
    let homeViewModel: TeamViewModel
    let awayViewModel: TeamViewModel
    let showHighlight: Bool
    private var bindings = Set<AnyCancellable>()
    private(set) var tappedWatchHighlight = PassthroughSubject<Void, Never>()
    private(set) var tappedTeamDetail = PassthroughSubject<String, Never>()

    init(
        dateHeaderViewModel: DateHeaderViewModel,
        highlightFooterViewModel: HighlightFooterViewModel,
        homeViewModel: TeamViewModel,
        awayViewModel: TeamViewModel,
        showHighlight: Bool
    ) {
        self.dateHeaderViewModel = dateHeaderViewModel
        self.highlightFooterViewModel = highlightFooterViewModel
        self.homeViewModel = homeViewModel
        self.awayViewModel = awayViewModel
        self.showHighlight = showHighlight
        self.tappedWatchHighlight = highlightFooterViewModel.tappedWatchHighlight
        homeViewModel.tappedTeamDetail
            .sink { [weak self] teamName in
                self?.tappedTeamDetail.send(teamName)
            }
            .store(in: &bindings)
        awayViewModel.tappedTeamDetail
            .sink { [weak self] teamName in
                self?.tappedTeamDetail.send(teamName)
            }
            .store(in: &bindings)
    }
}
