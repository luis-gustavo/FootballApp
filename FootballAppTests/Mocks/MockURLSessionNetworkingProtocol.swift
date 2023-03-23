//
//  MockURLSessionNetworkingProtocol.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import Combine
import Foundation
import Networking

final class MockURLSessionNetworkingProtocol: URLSessionNetworkingProtocol {

    // MARK: - Properties
    static let shared = MockURLSessionNetworkingProtocol()

    // MARK: - Init
    private init() { }

    // MARK: - URLSessionNetworkingProtocol
    func request(endPoint: Networking.EndPoint) -> AnyPublisher<Networking.NetworkResponse, Networking.NetworkError> {
        if let request = endPoint.createRequest() {
            let response = Networking.NetworkResponse(
                data: .init(),
                status: .okResponse,
                response: .init(),
                request: request
            )
            return Just(response)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NetworkError.dataMustExist)
                .eraseToAnyPublisher()
        }
    }
}
