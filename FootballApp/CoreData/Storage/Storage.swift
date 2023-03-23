//
//  Storage.swift
//  FootballApp
//
//  Created by Luis Gustavo on 22/03/23.
//

import CoreData
import Combine
import Foundation

protocol Storage {
    func createTeams(object: [Team]) -> AnyPublisher<Bool, Error>
    func createUpcomingMatches(object: [UpcomingMatch]) -> AnyPublisher<Bool, Error>
    func createPreviousMatches(object: [PreviousMatch]) -> AnyPublisher<Bool, Error>
    func fetch<T: NSManagedObject>(entityName: String) -> AnyPublisher<[T]?, Error>
}

struct StorageError {
    static let storageDataGeneral = NSError(
        domain: "An error raised while dealing with the storage.",
        code: 00,
        userInfo: nil
    )
    static let storageDataFetch = NSError(
        domain: "Something wrong happened while fetching from the storage.",
        code: 10,
        userInfo: nil
    )
    static let storageDataSave = NSError(
        domain: "Something wrong happened while saving on the storage.",
        code: 20,
        userInfo: nil
    )
    static let storageDataDelete = NSError(
        domain: "Something wrong happened while deleting on the storage.",
        code: 30,
        userInfo: nil
    )
}
