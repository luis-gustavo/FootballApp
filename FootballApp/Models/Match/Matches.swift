//
//  Matches.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import Foundation

struct Matches: Codable {

    // MARK: - Properties
    let previous: [PreviousMatch]
    let upcoming: [UpcomingMatch]
}
