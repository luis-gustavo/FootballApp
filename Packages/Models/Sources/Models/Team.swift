//
//  File.swift
//  
//
//  Created by Luis Gustavo on 22/03/23.
//

import Foundation

public struct Team: Codable {

    // MARK: - Properties
    public let logo: String
    public let id: String
    public let name: String

    // MARK: - Init
    public init(id: String, name: String, logo: String) {
        self.id = id
        self.name = name
        self.logo = logo
    }
}
