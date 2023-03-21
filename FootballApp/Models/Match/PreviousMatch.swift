//
//  PreviousMatch.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import Foundation

struct PreviousMatch: Codable, Hashable {

    // MARK: - Properties
    let description: String
    let home: String
    let away: String
    let winner: String
    let highlights: String
    var dateFormatted: String? {
        StringToDateFormatter.dateTimeFormatted(from: date)
    }
    private let date: String
}
