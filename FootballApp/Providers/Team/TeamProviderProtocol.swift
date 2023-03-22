//
//  TeamProviderProtocol.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import Combine
import Foundation
import Networking
import Models

protocol TeamProviderProtocol {
    func getTeams() -> AnyPublisher<[Team], NetworkError>
}
