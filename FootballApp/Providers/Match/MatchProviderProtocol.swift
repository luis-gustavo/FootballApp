//
//  MatchProviderProtocol.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import Combine
import Foundation
import Networking

protocol MatchProviderProtocol {
    func getMatches() -> AnyPublisher<Matches, NetworkError>
}
