//
//  TodoStorageManager.swift
//  FootballApp
//
//  Created by Luis Gustavo on 22/03/23.
//

import Combine
import CoreData
import Foundation
import Models

public struct StorageManager {

    // MARK: - Properties
    let mainContext: NSManagedObjectContext

    // MARK: - Inits
    public init(mainContext: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.mainContext = mainContext
    }
}

// MARK: - Storage
extension StorageManager: Storage {
    public func fetch<T: NSManagedObject>(entityName: String) -> AnyPublisher<[T]?, Error> {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)

        do {
            let objects = try mainContext.fetch(fetchRequest)
            return Just(objects)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }

    public func createTeams(object: [Team]) -> AnyPublisher<Bool, Error> {
        let teams = object
        for team in teams {
            let teamEntity = TeamEntity(context: mainContext)
            teamEntity.id = team.id
            teamEntity.name = team.name
            teamEntity.logo = team.logo
        }

        do {
            try mainContext.save()
            return Just(true)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }

    public func createPreviousMatches(object: [PreviousMatch]) -> AnyPublisher<Bool, Error> {
        let matches = object
        for match in matches {
            let teamEntity = PreviousMatchEntity(context: mainContext)
            teamEntity.home = match.home
            teamEntity.away = match.away
            teamEntity.matchDescription = match.description
            teamEntity.winner = match.winner
            teamEntity.highlights = match.highlights
            teamEntity.date = match.date
        }

        do {
            try mainContext.save()
            return Just(true)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }

    public func createUpcomingMatches(object: [UpcomingMatch]) -> AnyPublisher<Bool, Error> {
        let matches = object
        for match in matches {
            let teamEntity = UpcomingMatchEntity(context: mainContext)
            teamEntity.home = match.home
            teamEntity.away = match.away
            teamEntity.matchDescription = match.description
            teamEntity.date = match.date
        }

        do {
            try mainContext.save()
            return Just(true)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }

    //    func updateTeam(object: Team, completion: @escaping (Result<Bool, Error>) -> ()) {
    //        guard let teamObject = object as Any as? TeamObject,
    //              let teamData = teamObject.team else {
    //            completion(.failure(StorageError.storageDataGeneral))
    //            return
    //        }
    //
    //        let nsManagedObject = teamObject.managedObject
    //
    //        nsManagedObject.setValue(teamData.id, forKey: TeamObject.Key.id.rawValue)
    //        nsManagedObject.setValue(teamData.name, forKey: TeamObject.Key.name.rawValue)
    //        nsManagedObject.setValue(teamData.logo, forKey: TeamObject.Key.logo.rawValue)
    //
    //        do {
    //            try mainContext.save()
    //            completion(.success(true))
    //        } catch let error {
    //            completion(.failure(error))
    //        }
    //    }

//    func delete<T>(object: T, completion: @escaping (Result<Bool, Error>) -> ()) {
//        guard let managedObject = object as Any as? NSManagedObject else {
//            completion(.failure(StorageError.storageDataGeneral))
//            return
//        }
//
//        mainContext.delete(managedObject)
//
//        do {
//            try mainContext.save()
//            completion(.success(true))
//        } catch let error {
//            completion(.failure(error))
//        }
//    }
}
