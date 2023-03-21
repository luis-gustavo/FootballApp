//
//  MatchProvider.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import Combine
import Foundation
import DIContainer
import Networking

struct MatchProvider: MatchProviderProtocol {

    // MARK: - Properties
    private let networking: URLSessionNetworkingProtocol = DIContainer.make(for: URLSessionNetworkingProtocol.self)

    // MARK: - MatchProviderProtocol
    func getMatches() -> AnyPublisher<Matches, NetworkError> {
        return networking.request(endPoint: MatchEndpoint.matches)
            .tryMap { element in element.data }
            .decode(type: MatchResponse.self, decoder: JSONDecoder())
            .map { $0.matches }
            .mapError { $0 as? NetworkError ?? .unmapped($0) }
            .eraseToAnyPublisher()
    }

}
