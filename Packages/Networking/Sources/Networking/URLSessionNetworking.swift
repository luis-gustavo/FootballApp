//
//  URLSessionNetworking.swift
//  
//
//  Created by Luis Gustavo on 21/03/23.
//

import Combine
import Foundation

public struct URLSessionNetworking: URLSessionNetworkingProtocol {

    // MARK: - Properties
    public static let shared = URLSessionNetworking()

    // MARK: - Init
    private init() { }

    // MARK: - NetworkLayerProtocol
    @available(iOS 13.0, *)
    public func request(endPoint: EndPoint) -> AnyPublisher<NetworkResponse, NetworkError> {
        guard let url = endPoint.url else {
            return Fail(error: NetworkError.unableToCreateURL).eraseToAnyPublisher()
        }

        guard let request = endPoint.createRequest() else {
            return Fail(error: NetworkError.queryParameters(url, [:])).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.notHTTPURLResponse
                }

                guard let statusCode = HTTPStatusCode(rawValue: httpResponse.statusCode) else {
                    throw NetworkError.unknownStatusCode(httpResponse.statusCode)
                }

                return NetworkResponse(data: data, status: statusCode, response: httpResponse, request: request)
            }
            .mapError { ($0 as? NetworkError) ?? .unmapped($0) }
            .eraseToAnyPublisher()
    }
}
