//
//  File.swift
//  
//
//  Created by Luis Gustavo on 22/03/23.
//

import Foundation

public struct PreviousMatch: Codable, Hashable {

    // MARK: - Properties
    public let description: String
    public let home: String
    public let away: String
    public let winner: String
    public let highlights: String
    public let date: String

    // MARK: - Init
    public init(description: String, home: String, away: String, winner: String, highlights: String, date: String) {
        self.description = description
        self.home = home
        self.away = away
        self.winner = winner
        self.highlights = highlights
        self.date = date
    }
}
