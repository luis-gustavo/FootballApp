//
//  FileManagerProvider.swift
//  FootballApp
//
//  Created by Luis Gustavo on 23/03/23.
//

import Foundation

struct FileManagerProvider: FileManagerProviderProtocol {

    // MARK: - Properties
    static let shared = FileManagerProvider()

    // MARK: - Init
    init() { }
}
