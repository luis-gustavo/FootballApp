//
//  Team+imageUrl.swift
//  FootballApp
//
//  Created by Luis Gustavo on 22/03/23.
//

import Foundation
import Models

extension Team {
    var imageUrl: URL? {
        URL(string: logo)
    }
}
