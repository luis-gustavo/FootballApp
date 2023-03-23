//
//  MockStorage.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import Combine
import CoreData
import Models
import Storage

final class MockStorage: Storage {

    // MARK: - Properties
    static let shared = MockStorage()

    // MARK: - Init
    private init() { }

    // MARK: - Storage
    func fetch<T: NSManagedObject>(entityName: String) -> AnyPublisher<[T]?, Error> {
        return Fail(error: MockStorageError.error).eraseToAnyPublisher()
    }

    func createTeams(object: [Team]) -> AnyPublisher<Bool, Error> {
        return Just(true)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func createPreviousMatches(object: [PreviousMatch]) -> AnyPublisher<Bool, Error> {
        return Just(true)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func createUpcomingMatches(object: [UpcomingMatch]) -> AnyPublisher<Bool, Error> {
        return Just(true)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

enum MockStorageError: Error {
    case error
}
