//
//  File.swift
//  
//
//  Created by Luis Gustavo on 22/03/23.
//

import CoreData
import Models
import Foundation

public protocol UpcomingMatchObjectType {
    var managedObject: NSManagedObject { get set }
    var match: UpcomingMatch? { get }
}

public struct UpcomingMatchObject: UpcomingMatchObjectType {

    // MARK: - Properties
    public static var identifier = "UpcomingMatchEntity"
    var _managedObject: NSManagedObject!
    public var managedObject: NSManagedObject {
        get {
            return _managedObject
        } set {
            _managedObject = newValue
            fillModel(from: newValue)
        }
    }
    public var match: UpcomingMatch?

    // MARK: - Key
    enum Key: String {
        case matchDescription,
             home,
             away,
             date
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
           let date = managedObject.value(forKey: Key.date.rawValue) {
            let description = "\(description)"
            let away = "\(away)"
            let home = "\(home)"
            let date = "\(date)"

            match = UpcomingMatch(
                description: description,
                home: home,
                away: away,
                date: date
            )
        }
    }
}
