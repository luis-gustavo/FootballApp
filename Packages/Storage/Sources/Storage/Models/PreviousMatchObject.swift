//
//  File.swift
//  
//
//  Created by Luis Gustavo on 22/03/23.
//

import CoreData
import Foundation
import Models

public protocol PreviousMatchObjectType {
    var managedObject: NSManagedObject { get set }
    var match: PreviousMatch? { get }
}

public struct PreviousMatchObject: PreviousMatchObjectType {

    // MARK: - Properties
    public static var identifier: String = "PreviousMatchEntity"
    private var internalManagedObject: NSManagedObject!
    public var managedObject: NSManagedObject {
        get {
            return internalManagedObject
        } set {
            internalManagedObject = newValue
            fillModel(from: newValue)
        }
    }
    public var match: PreviousMatch?

    // MARK: - Key
    enum Key: String {
        case matchDescription,
             home,
             away,
             date,
             winner,
             highlights
    }

    // MARK: - Init
    public init(managedObject: NSManagedObject) {
        self.managedObject = managedObject
    }

    // MARK: - Private methods
    private mutating func fillModel(from managedObject: NSManagedObject) {
        if let description = managedObject.value(forKey: Key.matchDescription.rawValue),
           let home = managedObject.value(forKey: Key.home.rawValue),
           let away = managedObject.value(forKey: Key.away.rawValue),
           let date = managedObject.value(forKey: Key.date.rawValue),
           let winner = managedObject.value(forKey: Key.winner.rawValue),
           let highlights = managedObject.value(forKey: Key.highlights.rawValue) {
            let description = "\(description)"
            let away = "\(away)"
            let home = "\(home)"
            let date = "\(date)"
            let winner = "\(winner)"
            let highlights = "\(highlights)"

            match = PreviousMatch(
                description: description,
                home: home,
                away: away,
                winner: winner,
                highlights: highlights,
                date: date
            )
        }
    }
}
