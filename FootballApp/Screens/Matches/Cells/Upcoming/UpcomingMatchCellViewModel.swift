//
//  UpcomingMatchCellViewModel.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import Foundation

struct UpcomingMatchCellViewModel {

    // MARK: - Properties
    let dateHeaderViewModel: DateHeaderViewModel
    let homeViewModel: TeamViewModel
    let awayViewModel: TeamViewModel

    init(
        dateHeaderViewModel: DateHeaderViewModel,
        homeViewModel: TeamViewModel,
        awayViewModel: TeamViewModel
    ) {
        self.dateHeaderViewModel = dateHeaderViewModel
        self.homeViewModel = homeViewModel
        self.awayViewModel = awayViewModel
    }
}
