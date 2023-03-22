//
//  MatchesViewModelState.swift
//  FootballApp
//
//  Created by Luis Gustavo on 22/03/23.
//

import Foundation

enum MatchesViewModelState {
    case loadingTeams
    case loadingMatches
    case finishedLoading
    case error(MatchesViewModelError)
}
