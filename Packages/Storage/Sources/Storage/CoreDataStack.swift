//
//  CoreDataStack.swift
//  FootballApp
//
//  Created by Luis Gustavo on 22/03/23.
//

import CoreData
import Foundation

open class PersistentContainer: NSPersistentContainer { }

public final class CoreDataStack {

    // MARK: - Properties
    public static let shared = CoreDataStack()
    public let mainContext: NSManagedObjectContext
    let persistentContainer: NSPersistentContainer
    let backgroundContext: NSManagedObjectContext

    private init() {
        guard let modelURL = Bundle.module.url(forResource:"Storage", withExtension: "momd") else {
            fatalError("Unable to find storage")
        }
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to create model")
        }
        persistentContainer = PersistentContainer(name:"Storage", managedObjectModel: model)
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSSQLiteStoreType

        persistentContainer.loadPersistentStores { description, error in

            guard error == nil else {
                fatalError("was unable to load store \(error!)")
                // TODO: handle this error properly
            }
        }

        mainContext = persistentContainer.viewContext

        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        backgroundContext.parent = self.mainContext
    }
}
