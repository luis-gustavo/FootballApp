//
//  MockImageLoader.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import Combine
import Foundation
@testable import FootballApp

final class MockImageLoader: ImageLoaderProtocol {

    // MARK: - Properties
    static let shared = MockImageLoader()

    // MARK: - Init
    private init() { }

    // MARK: - ImageLoaderProtocol
    func downloadImage(_ url: URL) -> AnyPublisher<Data, Error> {
        guard let imageUrl = Bundle(for: ImageLoaderTests.self).url(forResource: "ball", withExtension: "png") else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        do {
            let data = try Data(contentsOf: imageUrl)
            return Just(data)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }

}
