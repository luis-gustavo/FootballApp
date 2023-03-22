//
//  File.swift
//  
//
//  Created by Luis Gustavo on 22/03/23.
//

import CoreData
import Foundation
import Models

public protocol TeamObjectType {
    var managedObject: NSManagedObject { get set }
    var team: Team? { get }
}

public struct TeamObject: TeamObjectType {

    // MARK: - Properties
    public static var identifier: String = "TeamEntity"
    var _managedObject: NSManagedObject!
    public var managedObject: NSManagedObject {
        get {
            return _managedObject
        } set {
            _managedObject = newValue
            fillModel(from: newValue)
        }
    }
    public var team: Team?

    // MARK: - Key
    enum Key: String {
        case id, logo, name, createdAt
    }

    // MARK: - Init
    public init(managedObject: NSManagedObject) {
        self.managedObject = managedObject
    }

    // MARK: - Private methods
    private mutating func fillModel(from managedObject: NSManagedObject) {
        if let id = managedObject.value(forKey: Key.id.rawValue),
           let name = managedObject.value(forKey: Key.name.rawValue),
           let logo = managedObject.value(forKey: Key.logo.rawValue) {
            let id = "\(id)"
            let name = "\(name)"
            let logo = "\(logo)"

            team = Team(
                id: id,
                name: name,
                logo: logo
            )
        }
    }
}
