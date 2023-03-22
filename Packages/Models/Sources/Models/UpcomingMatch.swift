//
//  File.swift
//  
//
//  Created by Luis Gustavo on 22/03/23.
//

import Foundation

public struct UpcomingMatch: Codable, Hashable {

    // MARK: - Properties
    public let description: String
    public let home: String
    public let away: String
    public let date: String

    // MARK: - Init
    public init(description: String, home: String, away: String, date: String) {
        self.description = description
        self.home = home
        self.away = away
        self.date = date
    }
}
