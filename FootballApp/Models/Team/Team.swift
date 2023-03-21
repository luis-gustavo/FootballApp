//
//  Team.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import Foundation

struct Team: Codable {

    // MARK: - Properties
    let id: String
    let name: String
    var imageUrl: URL? {
        URL(string: logo)
    }
    private let logo: String
}
