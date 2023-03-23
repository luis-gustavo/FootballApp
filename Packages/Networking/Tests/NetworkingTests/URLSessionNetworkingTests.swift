//
//  URLSessionNetworkingTests.swift
//  
//
//  Created by Luis Gustavo on 21/03/23.
//

import Combine
import Foundation
import XCTest
@testable import Networking

final class URLSessionNetworkingTests: XCTestCase {

    private let mock = MockUrlSessionNetworking()
    private var bindinds = Set<AnyCancellable>()

    func testSuccessfulRequest() {
        // Given
        let expectation = expectation(description: "successful request")
        let endpoint = MockEndpoint.correct

        // When
        mock.request(endPoint: endpoint)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTFail("It shouldn't fail")
                default:
                    break
                }
            }, receiveValue: { response in
                XCTAssertEqual(endpoint.createRequest(), response.request)
                expectation.fulfill()
            })
            .store(in: &bindinds)

        // Then
        wait(for: [expectation], timeout: 1)
    }

    func testErrorRequest() {
        // Given
        let expectation = expectation(description: "successful request")
        let endpoint = MockEndpoint.wrong

        // When
        mock.request(endPoint: endpoint)
            .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        XCTFail("It should generate an error fail")
                    case let .failure(error):
                        XCTAssertEqual(error, .unableToCreateURL)
                        expectation.fulfill()
                    }
                }) { _ in }
            .store(in: &bindinds)

        // Then
        wait(for: [expectation], timeout: 1)
    }
}

private final class MockUrlSessionNetworking: URLSessionNetworkingProtocol {
    func request(endPoint: Networking.EndPoint) -> AnyPublisher<Networking.NetworkResponse, Networking.NetworkError> {
        if let request = endPoint.createRequest() {
            let response = Networking.NetworkResponse(
                data: Data(),
                status: .okResponse,
                response: .init(),
                request: request
            )
            return Just(response)
                .setFailureType(to: Networking.NetworkError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NetworkError.unableToCreateURL)
                .eraseToAnyPublisher()
        }
    }
}

private enum MockEndpoint: EndPoint {
    case correct, wrong

    var url: URL? {
        switch self {
        case .correct:
            return .init(string: "https://www.google.com")
        case .wrong:
            return nil
        }
    }

    var method: Networking.HTTPMethod {
        .get
    }

    var headers: [String: String] {
        [:]
    }

    var queryParameters: [String: Any] {
        [:]
    }

    var body: Data? {
        nil
    }
}

private struct Mock: Codable {
    let age: Int
    let name: String
}
