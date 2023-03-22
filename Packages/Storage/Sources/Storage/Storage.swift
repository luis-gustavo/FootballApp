//
//  File.swift
//
//
//  Created by Luis Gustavo on 22/03/23.
//

import Combine
import CoreData
import Foundation
import Models

public protocol Storage {
    func fetch<T: NSManagedObject>(entityName: String) -> AnyPublisher<[T]?, Error>
    func createTeams(object: [Team]) -> AnyPublisher<Bool, Error>
    func createPreviousMatches(object: [PreviousMatch]) -> AnyPublisher<Bool, Error>
    func createUpcomingMatches(object: [UpcomingMatch]) -> AnyPublisher<Bool, Error>
}
