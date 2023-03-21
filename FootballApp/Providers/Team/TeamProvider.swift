//
//  TeamProvider.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import Combine
import DIContainer
import Foundation
import Networking

struct TeamProvider: TeamProviderProtocol {

    // MARK: - Properties
    private let networking: URLSessionNetworkingProtocol = DIContainer.make(for: URLSessionNetworkingProtocol.self)

    // MARK: - Methods
    func getTeams() -> AnyPublisher<[Team], NetworkError> {
        return networking.request(endPoint: TeamEndpoint.teams)
            .tryMap { element in element.data }
            .decode(type: TeamResponse.self, decoder: JSONDecoder())
            .map { $0.teams }
            .mapError { $0 as? NetworkError ?? .unmapped($0) }
            .eraseToAnyPublisher()
    }
}
